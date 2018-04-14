"""
"============================================================================
"File:        aws_dl.py
"Description: Python aws documentation reader (under development).
"Authors: Marcin Katulski ( marcin.katulski@gmail.com ),
"         Carl Hall ( carl.hall@gmail.com ),
"
"============================================================================
"""
import re
import codecs
import urllib
from bs4 import BeautifulSoup

class DownloadDoc:
    def __init__(self, url, doc,  proxy={} ):
        self._url = url
        self._doc = doc
        self._proxy = proxy
        self._resources = {}
        self._snippets = []

    def downloadList( self, resources_fname, snippets_fname ):
        print("Downloading: .... {0}".format(self._url+self._doc))
        self._site = urllib.urlopen( self._url+self._doc, proxies=self._proxy )
        html = self._site.read()
        self._listSoup = BeautifulSoup( html, "html.parser" )
        print("Searching list of types ...")
        div = self._listSoup.find_all("div",{"class":"highlights"})

        if len(div)==1:
            print("Processing types ...")
            refList = div[0].find_all("a")
            for i in refList:
                 if i.text!="AWS::CloudFormation::Init":
                    if i.attrs.has_key("href"):
                        print("{0}".format(i.text))
                    self._resources[ i.text ]={}
                    site = urllib.urlopen( self._url+i.attrs["href"],
                            proxies=self._proxy )
                    text = site.read()
                    sp = BeautifulSoup( text, "html.parser" )

                    self.collectResource(i.text, sp)
                    self.collectSnippet(i.text, sp)

        self.writeResources(resources_fname)
        self.writeSnippets(snippets_fname)

    def collectResource( self, text, sp ):
        dvs = sp.find_all("div",{"class":"section"})
        p = dvs[0].findChildren("p", recursive=False)
        self._resources[ text ]["doc"] =""
        for j in p:
            self._resources[ text ]["doc"] += re.sub("[\"']", " ", j.text+"\\n")
        hr = dvs[0].findChildren("div",{"class":"section"})
        self._resources[ text ]["properties"] = {}
        if len(hr)==0:
            return
        hr = hr[0].find_all("a")
        for prop in hr:
            if self._resources[text]["properties"].has_key( prop.text ):
                continue
            if re.match('\w+\s+', prop.text) is not None:
                continue
            "Try to load description for parameters"
            dvsx = dvs[0].find_all("div", {"class":"variablelist"})
            term = ""
            for xvsd in dvsx:
                span = xvsd.find_all("span", {"class":"term"}, text=prop.text)
                if len(span) != 0:
                    term=span[0].findParent().findNextSibling()
                    break
            self._resources[ text ]["properties"][prop.text]=re.sub("[\"']"," ",
                    re.sub("<.*?>","",re.sub("</p>",'\\n',"{0}".format(term))))

    def writeResources( self, fname ):
        with codecs.open(fname, "wb" , encoding='utf8' ) as file:
            file.write("let g:AWSTypes=")
            s=str(self._resources)
            s=re.sub("'", '"',s)
            s=re.sub("u\"","\"",s)
            file.write(s)

    def collectSnippet( self, text, sp ):
        dvs = sp.find_all("code",{"class":"nohighlight"})
        if len(dvs) > 0:
            short = re.sub('[^A-Z0-9]', '', text[5:]).lower()
            title = text
            self._snippets.append('snippet {0} "{1}"'.format(short, title))

            process_props = False
            prop_count = 1
            for line in dvs[0].text.split("\n"):
                line = line.rstrip()
                if len(line) > 0:
                    last_char = line[-1:]

                    if last_char in ['{', '}']:
                        self._snippets.append(line)
                    elif process_props:
                        # parse out the value to create a marker
                        colon_pos = line.find(':')
                        # The docs aren't consistently formatted, but we can be
                        prop = line[:colon_pos].rstrip() + ' : '
                        marker_text = re.sub('[^A-Za-z0-9]', '', line[colon_pos:])
                        marker = '${' + str(prop_count) + ':#' + marker_text + '}'

                        if '...' in line:
                            prop += '[ ' + marker + ' ]'
                        else:
                            prop += marker

                        if last_char == ',':
                            prop += ','

                        self._snippets.append(prop)
                        prop_count += 1
                    else:
                        self._snippets.append(line)

                    if '"Properties"' in line:
                        process_props = True

            self._snippets.append("endsnippet\n")

    def writeSnippets( self, fname ):
        with codecs.open(fname, "wb" , encoding='utf8' ) as file:
            with open('./ftplugin/aws/snippets.header', 'r') as header:
                file.write(header.read())
            for snippet in self._snippets:
                file.write(snippet + "\n")


if __name__ == "__main__":
    doc = DownloadDoc("http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/","aws-template-resource-type-ref.html")
    doc.downloadList( "./AWSTypes.vim", "./snips/aws.snippets" )

