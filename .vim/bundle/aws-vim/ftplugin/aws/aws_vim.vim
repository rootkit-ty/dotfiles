"============================================================================
"File:        aws_vim.vim
"Description: vim completion plugin to complete the aws Cloud Formation
"             Templates documents.
"Author: Marcin Katulski ( marcin.katulski@gmail.com )
"
"============================================================================
if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

if !exists("g:AWSVimValidate")
    let g:AWSVimValidate = 0
endif

if !exists("g:AWSSnips")
    let g:AWSSnips = ""
endif

runtime! AWSTypes.vim 

function! ClearTypes()
    for i in keys(g:AWSTypes)
        let p=g:AWSTypes[i]
        let p["doc"]=substitute(p["doc"], "\\\\n","\n","g")
        if has_key(p,"properties")
            for i in keys(p["properties"])
                let p["properties"][i] = substitute(p["properties"][i],"\\\\n","\n","g")
            endfor
        endif
    endfor
endfunction

call ClearTypes()
"=========        new functions      ==============
"
function! GetGroup0( doc, lineNr  )
    let p =copy( a:doc )
    call filter(p, 'has_key(v:val, "line") && has_key(v:val,"last") &&' .
                \  'v:val["line"]<=' . string(a:lineNr) . 
                \  '&& v:val["last"]>=' . string(a:lineNr ))
    if !empty(p)
        return keys(p)[0]
    endif
    return ""
endfunction

function! GetObjectType( doc, lineNr  )
    let group0 = GetGroup0( a:doc, a:lineNr )
    if empty(group0)
        return ""
    endif

    let p = copy( a:doc[ group0 ]['objects'] )
    call filter(p, 'v:val["first"]<=' . string(a:lineNr) . 
                \' && v:val["last"]>=' . string(a:lineNr))
    if !empty(p) && has_key(p[0],"type")
        return p[0]["type"]
    endif
    return ""
endfunction

function! IsProperty( doc, lineNr  )
    let group0 = GetGroup0( a:doc, a:lineNr )
    if empty(group0)
        return [0, [] ]
    endif

    let p = copy( a:doc[ group0 ]['objects'] )
    call filter(p, 'v:val["first"]<=' . string(a:lineNr) . 
                \ ' && v:val["last"]>=' . string(a:lineNr))
    if empty(p)
        return [0,[]]
    endif
    if has_key(p[0], "Properties")
        if p[0]["Properties"]["first"]<= a:lineNr && 
                    \ p[0]["Properties"]["last"]>=a:lineNr
            return [1, p[0]["Properties"]["list"] ]
        endif
    endif
    return [0, [] ]
endfunction

function! ListToDict( list )
    let ret={}
    for i in a:list
        if !empty(i)
            let ret[i]=0
        endif
    endfor
    return ret
endfunction

"===== functions that return proper list of completion

function! GetValuesList( doc, line, base )
    let result = []
    let res = GetGroup0( a:doc, a:line )
    let ltt = getline( line('.') )
    if empty(res)
        "return document values?? 
    elseif res=="Resources"
        let colNr = col('.')            
        let part  = ''
        while colNr>1 && !(ltt[colNr]=~'[^\"]')
            let part = part+ ltt[colNr]
        endwhile
        if part=~"\"Fn"       
            let tpart = substitute( part, ".*\(Fn[^\"]*\)", '\1' ) 
            call extend( result, GetIntrFunctions( tpart ))
        endif
    elseif res=="Parameters"
    
    elseif res=="Outputs"
    
    elseif res=="Conditions"
        return s:CondFunctions 
    endif 
    return result
endfunction

function! InParameters( doc, line )
    let group0 = GetGroup0( a:doc, a:line )
    if empty(group0)
        return ""
    endif

    let p = copy( a:doc[ group0 ]['objects'] )
    call filter(p, 'v:val["first"]<=' . string(a:line) . 
                \' && v:val["last"]>=' . string(a:line))
    if !empty(p) && has_key(p[0],"Properties") && has_key(p[0]["Properties"], "parameters") 
                \ && has_key(p[0]["Properties"]["parameters"], "url")
        if p[0]["Properties"]["parameters"]["url"]=~'^$'
            return [0, '']
        endif
        if a:line >=p[0]["Properties"]["parameters"]["first"] && p[0]["Properties"]["parameters"]["first"]>0      
            return [1, p[0]["Properties"]["parameters"]]    
        endif
    endif
    return [0, '' ]
endfunction 

function! GetPropertiesList( doc, line, base )
    let result = []
    let res = GetGroup0( a:doc, a:line )
    if empty(res)
        "return document types
        for i in range(0,len(s:DocTypes["1"])-1)
            if !has_key(a:doc,s:DocTypes[1][i]["word"] )
                if s:DocTypes[1][i]["word"] =~ a:base
                    call add( result, s:DocTypes[1][i] )
                endif
            endif
        endfor
    elseif res=="Resources"
        let [b,p] = IsProperty( a:doc, a:line )  
        if b==1
            let tp = GetObjectType( a:doc, a:line )
            if !empty(tp) && has_key(g:AWSTypes , tp )
                let tpd = g:AWSTypes[tp]
                let plist = ListToDict( p  )
                "special case for stack object
                let [ isPar, parDict ] = InParameters( a:doc, a:line )
                if tp=="AWS::CloudFormation::Stack" && isPar==1
                    let refDoc = AnalyzeDocFromFile( expand('%:p:h') . "\/" . parDict["url"] )
                    if has_key(refDoc, "Parameters")
                        let curDL = ListToDict(parDict["list"])
                        let paramList = GetParamsList( refDoc, a:base )                        
                        for objNo in range(0, len(paramList)-1)
                            if !has_key(curDL, paramList[objNo]["word"])
                                call add( result, paramList[objNo] )
                            endif
                        endfor
                    endif
                else
                    for i in sort(keys(tpd["properties"]))
                        if !has_key(plist, i)
                            if i=~a:base
                                call add( result, {"word":i, "info":tpd["properties"][i]} )
                            endif
                        endif
                    endfor
                endif
            endif
        else
            for i in range(0,len(s:DocTypes["2"])-1)
                if !has_key(a:doc,s:DocTypes[2][i]["word"] )
                    if s:DocTypes[2][i]["word"] =~ a:base
                        call add( result, s:DocTypes[2][i] )
                    endif
                endif
            endfor
        endif
    elseif res=="Parameters"
        for i in range(0,len(s:DocTypes["3"])-1)
            if !has_key(a:doc,s:DocTypes[3][i]["word"] )
                if s:DocTypes[3][i]["word"] =~ a:base
                    call add( result, s:DocTypes[3][i] )
                endif
            endif
        endfor
    elseif res=="Outputs"
        for i in range(0,len(s:DocTypes["6"])-1)
            if s:DocTypes[6][i]["word"] =~ a:base
                call add( result, s:DocTypes[6][i] )
            endif
        endfor
    endif 
    return result
endfunction


function! GetAWSTypesList( base )
    let result = []
    for i in sort(keys(g:AWSTypes))
        if i=~ a:base
            call add(result, {"word":i, "info": g:AWSTypes[i]["doc"] })
        endif
    endfor
    return result
endfunction

function! GetParamTypeList(doc,  base  )
    let result = []
    for i in range(0,len(s:DocTypes["4"])-1)
        if !has_key(a:doc,s:DocTypes[4][i]["word"] )
            if s:DocTypes[4][i]["word"] =~ a:base
                call add( result, s:DocTypes[4][i] )
            endif
        endif
    endfor
    return result
endfunction

function! GetIntrFunctions( base )
    let result = []
    for i in range(0,len(s:DocTypes["5"])-1)
        if s:DocTypes[5][i]["word"] =~ a:base
            call add( result, s:DocTypes[5][i] )
        endif
    endfor
    return result
endfunction

function! GetParamsList(doc, base)
    let result = []
    if has_key(a:doc, "Parameters")
        let params=a:doc["Parameters"]
        if has_key( params, "objects" )
            let obj=params["objects"]
            for i in range(0, len(obj)-1)
              let info = '  '
              if  has_key(obj[i], "info")
                  let info = obj[i]["info"]
              endif
              if has_key(obj[i], "name") && obj[i]["name"]=~a:base
                  call add(result, {"word": obj[i]["name"], "info": info, "menu": "Parameter object"})
              endif
            endfor
        endif
    endif
    return result
endfunction

function! GetResourceList(doc, base)
    let result = []
    if has_key(a:doc, "Resources")
        let params=a:doc["Resources"]
        if has_key( params, "objects" )
            let obj=params["objects"]
            for i in range(0, len(obj)-1)
                let info = '  '
                if has_key(obj[i], "type")
                    let info="Type: " . obj[i]["type"]
                endif
                if has_key(obj[i], "name") && obj[i]["name"]=~a:base
                    call add(result, {"word": obj[i]["name"], "info": info, "menu": "Resource object"})
                endif
            endfor
        endif
    endif
    return result
endfunction

function! GetPseudoParameters( base)
    let result = []
    for i in range(0,len(s:DocTypes["7"])-1)
        if s:DocTypes[7][i]["word"] =~ a:base
            let d=s:DocTypes[7][i]
            let d["menu"]="Pseudo parameter"
            call add( result, d )
        endif
    endfor
    return result
endfunction

function! GetTypeForName( doc, name  )
    let p =copy( a:doc )
    if !has_key(p, "Resources")
        return ""
    endif

    if !has_key(p["Resources"], "objects")
        return ""
    endif
    call filter(p["Resources"]["objects"], 'v:val["name"]=="' . a:name . '" && has_key(v:val, "type")')
    if !empty(p["Resources"]["objects"])
        return p["Resources"]["objects"][0]["type"]
    endif
    return ""
endfunction

function! GetParamsForName(doc, name  )
    let p =copy( a:doc )
    if !has_key(p, "Resources")
        return ""
    endif

    if !has_key(p["Resources"], "objects")
        return ""
    endif
    call filter(p["Resources"]["objects"], 'v:val["name"]=="' . a:name . '" && has_key(v:val, "Properties") ' . 
                \ ' && has_key(v:val["Properties"],"parameters")')
    if !empty(p["Resources"]["objects"])
        return p["Resources"]["objects"][0]["Properties"]["parameters"]
    endif
    return {}
endfunction

function! GetRefOutputs( url, base )
    let refDoc = AnalyzeDocFromFile( expand('%:p:h') . "\/" . a:url )
    let result = []
    if !has_key(refDoc, "Outputs")
        return result
    endif
    for i in range(0, len(refDoc["Outputs"]["objects"])-1)
        let name=refDoc["Outputs"]["objects"][i]["name"]
        if name=~a:base
            call add(result, "Outputs." . name)
        endif
    endfor
    return result
endfunction
" Sample dict from document analysis looks like:
" {
"   'Outputs': 
"   {
"       'last': 53, 
"       'line': 52, 
"       'objects': []
"   }, 
"   'Parameters': 
"   {
"       'last':  18, 
"       'line': 5, 
"       'objects': [
"           {'first': 6, 'name': 'Param1', 'info':'Description field', last': 11, 'type': 'String,'}, 
"           {'first': 12, 'name': 'KeyName'" , 'last': 17, 'type': 'String'}
"           ]
"    }, 
"    'Mappings': 
"    {
"       'last': 21, 
"       'line': 18,
"       'objects': []
"    }, 
"    'Conditions': 
"    {
"       'last': 24, 
"       'line': 21, 
"       'objects': []
"    },
"    'Resources': 
"    {
"       'last': 52, 
"       'line': 24, 
"       'objects': [
"              { 'first': 26, 'name': 'Test', 'last': 29}, 
"              { 'first': 30, 
"                   'Properties': {'first': 34, 'list': ['PolicyName'], 'last': 37}, 
"                   'name': 'Policy1', 'last': 38}, 
"              {'first': 39, 
"                   'Properties': {'first': 42, 'list': ['InstanceType', 'LaunchConfigurationName'], 'last': 47}, 
"                   'name':'OtherRes', 'last': 51, 'type': 'AWS::AutoScaling::AutoScalingGroup,'}
"                   ]
"     }
" }
function! AnalyzeDoc()
    let docDict = {} 
    let cCObject = {}
    let curObject = ""
    let line = 1
    let endline = line('$')
    let bracketsLevel = 0
    let lstt = getline( line )
    let bracketsLevel = bracketsLevel + 
                \ len( substitute(lstt, '[^{]', '' ,'g'))- 
                \ len( substitute(lstt, '[^}]', '' ,'g')) 
    let lvl5Name = ''
    let oType = ''

    let oneMore = 0
    while line < endline && line!=0
        if bracketsLevel == 1
            if curObject!=""
                if cCObject != {}
                    let cCObject['last']=line-1
                    call add(docDict[curObject]["objects"], cCObject)
                    let cCObject = {}
                endif
                let docDict[curObject]["last"]=line
            endif
            if lstt =~ "Parameters" 
                let curObject = "Parameters" 
                let docDict[curObject] = {"line":line, "objects":[]  }
            elseif lstt =~ "Resources" 
                let curObject = "Resources" 
                let docDict[curObject] = {"line":line, "objects":[]  }
            elseif lstt =~ "Outputs" 
                let curObject = "Outputs" 
                let docDict[curObject] = {"line":line, "objects":[]  }
            elseif lstt =~ "Mappings" 
                let curObject = "Mappings" 
                let docDict[curObject] = {"line":line, "objects":[]  }
            elseif lstt =~ "Conditions" 
                let curObject = "Conditions" 
                let docDict[curObject] = {"line":line, "objects":[]  }
            endif      
        elseif bracketsLevel == 2
            if lstt =~ '^\s*\"\w\+'
                if cCObject != {} && !empty(curObject)
                    let cCObject['last']=line-1
                    call add(docDict[curObject]["objects"], cCObject)
                    let cCObject = {}
                endif
                let objName = substitute(lstt,'^\s*\"\(\w\+\).*$','\1','g')
                let cCObject["name"]=objName
                let cCObject["first"]=line
            endif
        elseif bracketsLevel == 3
            if cCObject!={} && has_key(cCObject, "Properties")==1
                let cCObject["Properties"]["last"]=line-1
            endif
            if lstt =~ '\"Type\"\s*:\s*\"[a-zA-Z0-9:]\+\".*'
                let objType = substitute(lstt, '^\s*\"Type\"\s*:.*\"\([a-zA-Z0-9:]\+\)\"', '\1','g')
                let objType = substitute( objType, ',', '', 'g' )
                let cCObject["type"] = objType
                let oType = objType
            elseif lstt =~ '\"Properties\"\s*:'
                let cCObject["Properties"] = {}
                let cCObject["Properties"]['first'] = line
                let cCObject["Properties"]["list"] = []
            elseif lstt =~ '\"Description\"\s*:\s*\".*\".*'
                let objType = substitute(lstt, '^\s*\"Description\"\s*:.*\"\(.*\)\"', '\1','g')
                let objType = substitute( objType, ',', '', 'g' )
                let cCObject["info"] = objType
            endif
        elseif bracketsLevel == 4
            let lvl5Name = ''
            if lstt =~ '^\s*\"\w\+\"\s*:.*' && has_key(cCObject, "Properties") && !has_key( cCObject["Properties"], "last" )
                let nameProp = substitute( lstt, '^\s*\"\(\w\+\)\".*', '\1', 'g' )
                " additional data for lvl5
                if oType == "AWS::CloudFormation::Stack" && nameProp == "TemplateURL"
                    let value = substitute( lstt, '^\s*\"\w\+\"\s*:\s*\"\([^\"]\+\)\".*', '\1', 'g' )
                    if !has_key( cCObject["Properties"], "parameters" )
                        let cCObject["Properties"]["parameters"] = {}
                        let cCObject["Properties"]["parameters"]["first"] = -1
                        let fname=""
                        if value=~"Fn::Join"
                            let vallist=split(value,'[\[,"]')
                            let ind = len(vallist)-1
                            while ind>=0
                                if vallist[ind]=~'[A-Za-z0-9\-_\.]\+'
                                    let fname=vallist[ind]
                                    break
                                endif
                                let ind=ind-1
                            endwhile
                        else
                            let vallist=split(value,'\/')
                            let fname=vallist[ len(vallist)-1 ]
                        endif
                        let dir=expand("%:p:h")
                        if !( findfile( fname , expand('%:p:h') )=~'^$' )
                            let cCObject["Properties"]["parameters"]["url"] = fname
                        endif
                        let cCObject["Properties"]["parameters"]["list"] = []
                    endif
                endif
                if oType == "AWS::CloudFormation::Stack" && nameProp == "Parameters"
                    let lvl5Name = 'stackParameters' 
                    if !has_key( cCObject["Properties"], "parameters" )
                        let cCObject["Properties"]["parameters"] = {}
                        let cCObject["Properties"]["parameters"]["first"] = -1
                        let cCObject["Properties"]["parameters"]["url"] = ''
                        let cCObject["Properties"]["parameters"]["list"] = []
                    endif
                    let cCObject["Properties"]["parameters"]["first"] = line+1
                endif
                call add(cCObject["Properties"]["list"], nameProp)
            endif
        elseif bracketsLevel == 5
            if lstt =~ '^\s*\"\w\+\"\s*:.*' && lvl5Name == 'stackParameters'
                let name = substitute( lstt, '^\s*\"\(\w\+\)\".*', '\1', 'g' )
                if !has_key( cCObject["Properties"], "parameters" )
                    let cCObject["Properties"]["parameters"] = {}
                    let cCObject["Properties"]["parameters"]["url"] = ""
                    let cCObject["Properties"]["parameters"]["list"] = []
                endif
                call add( cCObject["Properties"]["parameters"]["list"], name )
            endif
        endif
        let line = line+1
        let line = nextnonblank(line)
        let lstt = getline(line)
        let bracketsLevel += oneMore
        if lstt=~ '^\s*"\w\+"\s*:\s*{'
            let oneMore = 
                        \ len( substitute(lstt, '[^{]', '' ,'g'))- 
                        \ len( substitute(lstt, '[^}]', '' ,'g')) 
        else
            let bracketsLevel = bracketsLevel + 
                        \ len( substitute(lstt, '[^{]', '' ,'g'))- 
                        \ len( substitute(lstt, '[^}]', '' ,'g')) 
            let oneMore = 0
        endif
    endwhile
    return docDict
endfunction


function! AnalyzeDocFromFile( filename )
    let file = readfile( a:filename )
    
    let docDict = {} 
    let cCObject = {}
    let curObject = ""
    let line = 0
    let endline = len(file)-1
    let bracketsLevel = 0

    let lstt = file[ line ]
    let bracketsLevel = bracketsLevel + 
                \ len( substitute(lstt, '[^{]', '' ,'g'))- 
                \ len( substitute(lstt, '[^}]', '' ,'g')) 

    let oneMore = 0
    while line < endline && line!=0
        if bracketsLevel == 1
            if curObject!=""
                if cCObject != {}
                    let cCObject['last']=line-1
                    call add(docDict[curObject]["objects"], cCObject)
                    let cCObject = {}
                endif
                let docDict[curObject]["last"]=line
            endif
            if lstt =~ "Parameters" 
                let curObject = "Parameters" 
                let docDict[curObject] = {"line":line, "objects":[]  }
            elseif lstt =~ "Resources" 
                let curObject = "Resources" 
                let docDict[curObject] = {"line":line, "objects":[]  }
            elseif lstt =~ "Outputs" 
                let curObject = "Outputs" 
                let docDict[curObject] = {"line":line, "objects":[]  }
            elseif lstt =~ "Mappings" 
                let curObject = "Mappings" 
                let docDict[curObject] = {"line":line, "objects":[]  }
            elseif lstt =~ "Conditions" 
                let curObject = "Conditions" 
                let docDict[curObject] = {"line":line, "objects":[]  }
            endif      
        elseif bracketsLevel == 2
            if lstt =~ '^\s*\"\w\+'
                if cCObject != {} && !empty(curObject)
                    let cCObject['last']=line-1
                    call add(docDict[curObject]["objects"], cCObject)
                    let cCObject = {}
                endif
                let objName = substitute(lstt,'^\s*\"\(\w\+\).*$','\1','g')
                let cCObject["name"]=objName
                let cCObject["first"]=line
            endif
        elseif bracketsLevel == 3
            if cCObject!={} && has_key(cCObject, "Properties")==1
                let cCObject["Properties"]["last"]=line-1
            endif
            if lstt =~ '\"Type\"\s*:\s*\"[a-zA-Z0-9:]\+\".*'
                let objType = substitute(lstt, '^\s*\"Type\"\s*:.*\"\([a-zA-Z0-9:]\+\)\"', '\1','g')
                let objType = substitute( objType, ',', '', 'g' )
                let cCObject["type"] = objType
                let oType = objType
            elseif lstt =~ '\"Properties\"\s*:'
                let cCObject["Properties"] = {}
                let cCObject["Properties"]['first'] = line
                let cCObject["Properties"]["list"] = []
            elseif lstt =~ '\"Description\"\s*:\s*\".*\".*'
                let objType = substitute(lstt, '^\s*\"Description\"\s*:.*\"\(.*\)\"', '\1','g')
                let objType = substitute( objType, ',', '', 'g' )
                let cCObject["info"] = objType
            endif
        elseif bracketsLevel == 4
            let lvl5Name = ''
            if lstt =~ '^\s*\"\w\+\"\s*:.*' && has_key(cCObject, "Properties") && !has_key( cCObject["Properties"], "last" )
                let nameProp = substitute( lstt, '^\s*\"\(\w\+\)\".*', '\1', 'g' )
                " additional data for lvl5
                if oType == "AWS::CloudFormation::Stack" && nameProp == "TemplateURL"
                    let value = substitute( lstt, '^\s*\"\w\+\"\s*:\s*\"\([^\"]\+\)\".*', '\1', 'g' )
                    if !has_key( cCObject["Properties"], "parameters" )
                        let cCObject["Properties"]["parameters"] = {}
                        let cCObject["Properties"]["parameters"]["first"] = -1
                        let fname=""
                        if value=~"Fn::Join"
                            let vallist=split(value,'[\[,"]')
                            let ind = len(vallist)-1
                            while ind>=0
                                if vallist[ind]=~'[A-Za-z0-9\-_\.]\+'
                                    let fname=vallist[ind]
                                    break
                                endif
                                let ind=ind-1
                            endwhile
                        else
                            let vallist=split(value,'\/')
                            let fname=vallist[ len(vallist)-1 ]
                        endif
                        let dir=expand("%:p:h")
                        if !( findfile( fname , expand('%:p:h') )=~'^$' )
                            let cCObject["Properties"]["parameters"]["url"] = fname
                        endif
                        let cCObject["Properties"]["parameters"]["list"] = []
                    endif
                endif
                if oType == "AWS::CloudFormation::Stack" && nameProp == "Parameters"
                    let lvl5Name = 'stackParameters' 
                    if !has_key( cCObject["Properties"], "parameters" )
                        let cCObject["Properties"]["parameters"] = {}
                        let cCObject["Properties"]["parameters"]["first"] = -1
                        let cCObject["Properties"]["parameters"]["url"] = ''
                        let cCObject["Properties"]["parameters"]["list"] = []
                    endif
                    let cCObject["Properties"]["parameters"]["first"] = line+1
                endif
                call add(cCObject["Properties"]["list"], nameProp)
            endif
        elseif bracketsLevel == 5
            if lstt =~ '^\s*\"\w\+\"\s*:.*' && lvl5Name == 'stackParameters'
                let name = substitute( lstt, '^\s*\"\(\w\+\)\".*', '\1', 'g' )
                if !has_key( cCObject["Properties"], "parameters" )
                    let cCObject["Properties"]["parameters"] = {}
                    let cCObject["Properties"]["parameters"]["url"] = ""
                    let cCObject["Properties"]["parameters"]["list"] = []
                endif
                call add( cCObject["Properties"]["parameters"]["list"], name )
            endif
        endif
        let line = line+1
        while( file[ line  ] =~ '^\s*$' )
            let line = line+1
        endwhile
        let lstt = file[ line ]
        let bracketsLevel += oneMore
        if lstt=~ '^\s*"\w\+"\s*:\s*{'
            let oneMore = 
                        \ len( substitute(lstt, '[^{]', '' ,'g'))- 
                        \ len( substitute(lstt, '[^}]', '' ,'g')) 
        else
            let bracketsLevel = bracketsLevel + 
                        \ len( substitute(lstt, '[^{]', '' ,'g'))- 
                        \ len( substitute(lstt, '[^}]', '' ,'g')) 
            let oneMore = 0
        endif
    endwhile
    return docDict
endfunction


"==================================================

function! FormatWithBase( list, base  )
    let ret=[]
    for i in a:list
        if i=~a:base
            call add(ret, i)
        endif
    endfor
    return ret
endfunction


function! AWSComplete( start, base )
    if a:start
	    let line = getline('.')
	    let start = col('.') - 1
	    while start > 0 && (line[start - 1] =~ '\a' || line[start-1] =~ '\d' ||
                    \ line[start-1] =~':')
	      let start -= 1
	    endwhile
	    return start
    else
        let doc=AnalyzeDoc()
        let group0 = GetGroup0(doc, line('.'))
        let bs = ''
        let col = col('.')        
        let line = getline('.')        
        let part = ''
        let start = col
        if line=~'^\s*\w*\s*$'            
            let b = substitute(line, '\s', '','g')                        
            return FormatWithBase( split( g:AWSSnips) , a:base)
        endif

        while start>1
            let part = line[ start ] . part
            if part =~ '\(Ref|\"Type\"\s*[:]|\"Fn::GetAtt\"\)'
                break               
            endif
            let start = start-1            
        endwhile
        if part=~"Ref"
            let ret = extend( extend(GetParamsList(doc, a:base), GetResourceList(doc, a:base) ), GetPseudoParameters(a:base))
            return ret
        elseif part=~"\"Type\"\s*"
            let base = substitute( part, '.*\"Type\"\s*\:\s*\"', '', 'g' )
            if group0 == "Resources"
                return GetAWSTypesList( a:base )
            else
                return GetParamTypeList(doc, a:base )
            endif
        
        elseif part=~"\"Fn::GetAtt\""
            let col=col('.')
            let part2=strpart(line, 0, col-1)
            if part2=~'\"Fn::GetAtt\"\s*[:]\s*[\[]\s*\"\w*$'
                return GetResourceList( doc, a:base )
            else
                let part2=substitute(line, '.*\"Fn::GetAtt\".*[\[]\s*\"\(\w\+\).*', '\1', "g" )
                let type = GetTypeForName( doc, part2 )
                " special case for stack inside
                if type == "AWS::CloudFormation::Stack"
                    let params = GetParamsForName( doc, part2 )
                    
                    if params != {} 
                        return GetRefOutputs( params["url"], a:base )
                    endif
                else
                    if has_key( s:AtrType, type )
                        return FormatWithBase( split( s:AtrType[type] ), a:base )
                    endif
                endif
                return [] 
            endif
        else
            let p=[]
            if ! (part=~'\s*"\w\+"\s*:.*')
                let p= GetPropertiesList(doc, line('.'), a:base)
            else
                " value is edited - future completion of subtypes like policy
                " documents or health check configurations
            endif
            return p
        endif
        return []
    endif
endfunction

set completefunc=AWSComplete
" ==================== vlaidation functions
"
function! AWSValidate( )
    if g:AWSVimValidate==0
        return
    endif
    call clearmatches() 
    let p =AnalyzeDoc()
    let qflist = []
    let resL = []
    let parL = []
    let awsL = []
    let parLines = {}
    let pos = getpos(".")
    let err = 0 
" json validation 
" validation of number of braces {}
    let line = 1
    let brnum = 0
    let enddoc = 0
    while line<=line('$')
        let line = nextnonblank(line)
        let lstt = getline( line )
        let brnum = brnum + 
                    \ len( substitute(lstt, '[^{]', '' ,'g'))- 
                    \ len( substitute(lstt, '[^}]', '' ,'g')) 
        if enddoc==1 && brnum>0 
            let bqf = {}
            let bqf["bufnr"] = bufnr('')
            let bqf["lnum"] = line-1 
            let bqf["pattern"] = '\%' .  line-1 . 'l.*'
            let bqf["col"] = 1
            let bqf["text"] = "Document has ended faster then it should check number of closing braces"
            let bqf["type"] = 'E'
            call add(qflist, bqf)
            call setqflist(qflist)
            echoerr "There are some errors, please check the list"
            return
        endif
        if brnum ==0 
            let enddoc = 1
        endif
        if brnum <0 
            let bqf = {}
            let bqf["bufnr"] = bufnr('')
            let bqf["lnum"] = line-1 
            let bqf["pattern"] = '\%' .  line-1 . 'l.*'
            let bqf["col"] = 1
            let bqf["text"] = "To many closing braces"
            let bqf["type"] = 'E'
            call add(qflist, bqf)
            call setqflist(qflist)
            echoerr "There are some errors, please check the list"
            return            
        endif
        let line = line+1
    endwhile
    if brnum>0 
            let bqf = {}
            let bqf["bufnr"] = bufnr('')
            let bqf["lnum"] = line-1 
            let bqf["pattern"] = '\%' .  line-1 . 'l.*'
            let bqf["col"] = 1
            let bqf["text"] = "To many opening braces"
            let bqf["type"] = 'E'
            call add(qflist, bqf)
            call setqflist(qflist)
            echoerr "There are some errors, please check the list"
            return            
    endif

    let regS = [
            \ '\"\_s\+\"',
            \ '}\_s\+\"',
            \ '\"[^\"]\+\"\_s\+\(\[\|{\)',
            \ '\zs\"\_s*,\_s\+\(\]\|}\)\ze',
            \ '^\s\+\"[^\"]\{-1,},',
            \ '^\_s\+[^{\[\"\t\ ]\+\"',
            \ '}\_s*,\_s\+}',
            \ '}\_s*,\_s\+\]',
            \]
    for reg in range(0, len(regS)-1 )
        call cursor(1,1)
        let w = search( regS[reg], 'W', line('$') )
        if w!=0 
            let bqf = {}
            let bqf["bufnr"] = bufnr('')
            let bqf["lnum"] = w 
            let bqf["pattern"] = regS[reg]
            let bqf["col"] = 1
            let bqf["text"] = "Wrongly formatted json"
            let bqf["type"] = 'E'
            call add(qflist, bqf)
            let err = 1
        endif
    endfor
    if err==1
        call setqflist(qflist)
        echoerr "There are some errors, please check the list"
        return            
    endif

    if has_key(p, "Resources")
        let obj = p["Resources"]["objects"]
        for i in range(0,len(obj)-1)
            if has_key( obj[i], "name")
                call add( resL, obj[i]["name"])
                if !has_key(obj[i], "type" )
                    call cursor(1,1)
                    call search('"' . obj[i]["name"] .'"\s*:', 'W', line('$') )
                    echoerr "Missing type value for resource : " . obj[i]["name"]
                    echom   "Missing type value for resource : " . obj[i]["name"]
                    call matchadd("Error", '\%' . obj[i]["first"] . 'l\zs' . obj[i]["name"] . '\ze')
                    return 
                endif
                "check if the properties are correct
                if has_key( obj[i], "Properties" )
                    let prop = obj[i]["Properties"]  
                    if has_key(prop,"list")
                       for j in prop["list"]
                            if !has_key( g:AWSTypes[ obj[i]["type"]]["properties"], j )
                                echoerr "Wrong property used: " . j 
                                echomsg "Wrong property used: " . j
                                call matchadd("Error", '\%>' . prop["first"] . 'l\%<' . prop["last"] . 'l\zs' . j . '\ze')
                                call cursor(1,1)
                                call search('\%>' . prop["first"] . 'l\%<' . prop["last"] . 'l' . j , 'W', line('$'))
                                return 
                            endif
                       endfor 
                    endif
                endif
            endif
        endfor
    endif
    
    if has_key(p, "Parameters")
        let obj = p["Parameters"]["objects"]
        for i in range(0,len(obj)-1)
            if has_key(obj[i],"name")
               call add( parL, obj[i]["name"])
               if has_key( obj[i], "first" )
                   let parLines[ obj[i]["name"] ] = obj[i]["first"] 
               endif
            endif
        endfor
    endif

    if has_key(s:DocTypes, "7" )
        for i in range(0,len(s:DocTypes["7"])-1)
            call add(awsL, s:DocTypes["7"][i]["word"])
        endfor
    endif

    let resD = ListToDict( resL )
    let parD = ListToDict( parL )
    let awsD = ListToDict( awsL )
    call cursor(1,1)
    let w=search('{\_s*"Ref"\s*:\_s*"\zs\w\+\ze"\_s*}', 'W', line('$') )
    while w!=0 
        let name=substitute(getline('.'),'.*{\s*','', '' )
        let name=substitute(name,'"Ref"\s*:\s*"\(\w\+\)".*', '\1', '' )
        let name=substitute(name, '\s', '','g')
        if !has_key(resD, name) && !has_key(parD, name) && !has_key(awsD, name)
            echoerr "Missing reference parameter : " . name . " in parameters section"
            echom "Missing reference parameter : " . name . " in parameters section"
            call matchadd("Error", '\%' . w . 'l\zs' . name . '\ze')
            return 
        endif
        if has_key(parD, name)
            let parD[name]=1
        endif
        let w=search('{\_s*"Ref"\s*:\_s*"\zs\w\+\ze"\_s*}', 'W', line('$') )
    endwhile
    " check if there are some unused template values
    call filter( parD, "parD[v:key]==0" )
    if !empty(parD)
        echoerr "There are unused parameters"
        let lMin = line('$')+1      
        let lMinN = ''
        let emp = 0
        for i in keys(parD)
            call matchadd("Error", '"\zs'. i . '\ze"\s*:')
            let bqf = {}
            let bqf["bufnr"] = bufnr('')
            let bqf["lnum"] = parLines[i]
            let bqf["pattern"] = '"\zs'. i . '\ze"\s*:'
            let bqf["col"] = 1
            let bqf["text"] = "Unused parameter "
            let bqf["type"] = 'W'
            call add(qflist, bqf)
            if parLines[i] < lMin
                let lMin = parLines[i]
                let lMinN = i
                let emp = 1
            endif
            echom i
        endfor
        if emp==1
            call cursor(1,lMin)
            let w=search('"\zs'. lMinN . '\ze"')
            call setqflist( qflist)
            return
        endif
    endif
    call setpos(".", pos)
endfunction


au! BufWrite *.template call AWSValidate()

"=========================================

let s:CondFunctions = [
            \ { "word": "Fn::And",  "info" : "Returns true if all the specified conditions evaluate to true, or returns false if any one of the conditions evaluates to false.\n Fn::And acts as an AND operator.\n The minimum number of conditions that you can include is 2, and the maximum is 10.\nDeclaration \n\"Fn::And\": [{condition}, {...}]"},
            \ { "word": "Fn::Equals",  "info" : "Compares if two values are equal. Returns true if the two values are equal or false if they aren't.\n Declaration\n \"Fn::Equals\" : [\"value_1\", \"value_2\"]"},
            \ { "word": "Fn::If",  "info" : "Returns one value if the specified condition evaluates to true and another value if the specified condition evaluates to false.\n Currently, AWS CloudFormation supports the Fn::If intrinsic function in the metadata attribute, update policy attribute, and property values in the Resources section and Outputs sections of a template.\n You can use the AWS::NoValue pseudo parameter as a return value to remove the corresponding property.\n Declaration\n \"Fn::If\": [condition_name, value_if_true, value_if_false]"},
            \ { "word": "Fn::Not",  "info" : "Returns true for a condition that evaluates to false or returns false for a condition that evaluates to true.\n Fn::Not acts as a NOT operator.\nDeclaration\n \"Fn::Not\": [{condition}]"},
            \ { "word": "Fn::Or",  "info" : "Returns true if any one of the specified conditions evaluate to true, or returns false if all of the conditions evaluates to false.\n Fn::Or acts as an OR operator.\n The minimum number of conditions that you can include is 2, and the maximum is 10.\n Declaration\n \"Fn::Or\": [{condition}, {...}]"},
            \ ]

let g:AWSSnips = "Alarm Authentication Base64 CreationPolicy FindInMap GetAtt Init Instance InstanceProfile Join LaunchConfiguration LoadBalancer Param Policy RDSIngress Ref Role SGEgress SGIngress ScalingPolicy ScheduledAction SecurityGroup Select Stack Subnet VPC Volume VolumeAttachment WaitCondition WaitConditionHandle asg cft init_command init_file init_group init_user"

let s:AtrType = {
            \ "AWS::CloudFormation::WaitCondition" : "Data",
            \ "AWS::CloudFormation::Stack" : "Outputs.",
            \ "AWS::CloudFront::Distribution" : "DomainName",
            \ "AWS::EC2::EIP" : "AllocationId",
            \ "AWS::EC2::Instance" : "AvailabilityZone PrivateDnsName PublicDnsName PrivateIp PublicIp",
            \ "AWS::EC2::NetworkInterface" : "PrimaryPrivateIpAddress SecondaryPrivateIpAddresses",
            \ "AWS::EC2::SecurityGroup" : "GroupId",
            \ "AWS::EC2::Subnet" : "AvailabilityZone",
            \ "AWS::EC2::SubnetNetworkAclAssociation" : "AssociationId",
            \ "AWS::EC2::VPC" : "DefaultNetworkAcl DefaultSecurityGroup",
            \ "AWS::ElastiCache::CacheCluster" : "ConfigurationEndpoint.Address ConfigurationEndpoint.Port",
            \ "AWS::ElasticBeanstalk::Environment" : "EndpointURL",
            \ "AWS::ElasticLoadBalancing::LoadBalancer": "CanonicalHostedZoneName CanonicalHostedZoneNameID DNSName SourceSecurityGroup.GroupName SourceSecurityGroup.OwnerAlias",
            \ "AWS::IAM::AccessKey" : "SecretAccessKey",
            \ "AWS::IAM::Group" : "Arn",
            \ "AWS::IAM::InstanceProfile": "Arn",
            \ "AWS::IAM::Role" : "Arn",
            \ "AWS::IAM::User": "Arn",
            \ "AWS::Redshift::Cluster" : "Endpoint.Address Endpoint.Port",
            \ "AWS::RDS::DBInstance" : "Endpoint.Address Endpoint.Port",
            \ "AWS::S3::Bucket" : "DomainName WebsiteURL",
            \ "AWS::SNS::Topic" : "TopicName",
            \ "AWS::SQS::Queue" : "Arn QueueName"
            \ }

let s:DocTypes = {
    \ "1" : [
    \       { "word": "AWSTemplateFormatVersion\" : \"2010-09-09\"" , "info": "Version of the template"},
    \       { "word": "Conditions","info": "Group of logical conditions"},
    \       { "word": "Description"  ,"info": "Description of the template"},
    \       { "word": "Mappings"  ,"info": "Group of mapped key-value objects"},
    \       { "word": "Outputs"   ,"info": "Group of returned values by template"},
    \       { "word": "Outputs"   ,"info": "Group of returned values by template"},
    \       { "word": "Parameters","info": "Group of template parameters objects"},
    \       { "word": "Resources" ,"info": "Group of template resource objects"}
    \       ] ,
    \ "2" : [
    \       { "word": "DependsOn" , "info": "Resource object that this one depends on"},
    \       { "word": "Properties" , "info": "Section with properties of resource object"},
    \       { "word": "Type" , "info": "Type of resource object"},
    \       ],
    \ "3" : [
    \       { "word": "AllowedPattern" , "info": "Regular expresion that inut value must met"},
    \       { "word": "AllowedValues" , "info": "List of allowed vallues"},
    \       { "word": "ConstraintDescription" , "info": "Description of constaints"},
    \       { "word": "Default" , "info": "Default value to be used"},
    \       { "word": "Description" , "info": "Description of the parameter"},
    \       { "word": "MaxLength" , "info": "Maximum length "},
    \       { "word": "MaxValue" , "info": "Maximum value"},
    \       { "word": "MinLength" , "info": "Minimum length"},
    \       { "word": "MinValue" , "info": "Minimum value"},
    \       { "word": "NoEcho" , "info": "Don't expose characters when inserted (used for password input)"},
    \       { "word": "Type" , "info": "Type of parameter"},
    \       ],
    \ "4" : [
    \ {"word":"Number","info":"An integer or float. AWS CloudFormation validates the parameter value as a number; however,\n when you use the parameter elsewhere in your template (for example, \nby using the Ref intrinsic function), the parameter value becomes a string."},
            \ {"word":"String","info":"A literal string. "},
            \ {"word":"AWS::EC2::KeyPair::KeyName","info":"An Amazon EC2 key pair name "},
            \ {"word":"AWS::EC2::SecurityGroup::Id","info":"A security group ID "},
            \ {"word":"AWS::EC2::Subnet::Id","info":"A subnet Id "},
            \ {"word":"AWS::EC2::VPC::Id","info":"A VPC ID "},
            \ {"word":"CommaDelimitedList","info":"An array of literal strings that are separated by commas. \nThe total number of strings should be one more than the total number of commas. \nAlso, each member string is space trimmed. "},
            \ {"word":"List<AWS::EC2::SecurityGroup::Id>","info":"An array of security group IDs "},
            \ {"word":"List<AWS::EC2::Subnet::Id>","info":"An array of subnet IDs"},
            \ {"word":"List<AWS::EC2::VPC::Id>","info":"An array of VPC IDs "},
            \ {"word":"List<Number>","info":"An array of integers or floats that are separated by commas.\n AWS CloudFormation validates the parameter value as numbers; however, when you use the parameter elsewhere \nin your template (for example, by using the Ref intrinsic function), \nthe parameter value becomes a list of strings. "},
    \       ],
    \ "5" : [
    \ {"word":"Fn::Base64","info":"The intrinsic function Fn::Base64 returns the Base64 representation of the input string. \nThis function is typically used to pass encoded data to Amazon EC2 instances by way of the UserData property.\nDeclaration: { \"Fn::Base64\" : valueToEncode  }"},
    \ {"word":"Fn::FindInMap","info":"The intrinsic function Fn::FindInMap returns the value corresponding to keys in a two-level map that is declared in the Mappings section\nDeclaration: \"Fn::FindInMap\" : [ \"MapName\", \"TopLevelKey\", \"SecondLevelKey\" ]\nMapName The logical name of a mapping declared in the Mappings section that contains the keys and values.\nTopLevelKey The top-level key name. Its value is a list of key-value pairs\n SecondLevelKey The second-level key name, which is set to one of the keys from the list assigned to TopLevelKey. "},
    \ {"word":"Fn::GetAZs","info":"Intrinsic function Fn::GetAZs returns an array that lists Availability Zones for a specified region. \nBecause customers have access to different Availability Zones, the intrinsic function Fn::GetAZs enables \ntemplate authors to write templates that adapt to the calling user's access. \nThat way you don't have to hard-code a full list of Availability Zones for a specified region.\n For the EC2-Classic platform, the Fn::GetAZs function returns all Availability Zones for a region. For the EC2-VPC platform, the Fn::GetAZs\n function returns all Availablity Zones, except for the US East (N. Virginia) region. In the US East (N. Virginia) region, only Availability Zones that have default\n subnets are returned unless no Availability Zones has a default subnet; \nin that case, all Availability Zones are returned.\n IAM permissions\n The permissions that you need in order to use the Fn::GetAZs function depend on the platform in which you're launching Amazon EC2 instances. \nFor both platforms, you need permissions to the Amazon EC2 DescribeAvailabilityZones and DescribeAccountAttributes actions.\n For EC2-VPC, you also need permissions to the Amazon EC2 DescribeSubnets action. "},
    \       ],
    \ "6" : [
    \       { "word": "Value" ,  "info": "The value of the property that is returned by the aws cloudformation describe-stacks command.\n Required: yes"},
    \       { "word": "Description" ,  "info": "A String type up to 4K in length describing the output value.\n Required: no"},
    \       { "word": "Condition" ,  "info": "Conditionally create outputs by adding a Condition property and then refer to a condition that is defined in the Conditions section of a template.\n Required: no"},
    \       ],
    \ "7" : [
    \       { "word": "AWS::AccountId" ,  "info": "Returns the AWS account ID of the account in which the stack is being created. "},
    \       { "word": "AWS::NotificationARNs" ,  "info": "Returns the list of notification Amazon Resource Names (ARNs) for the current stack."},
    \       { "word": "AWS::NoValue" ,  "info": "Removes the corresponding resource property when specified as a return value in the Fn::If intrinsic function.\n For example, you can use the AWS::NoValue parameter when you want to use a snapshot for an Amazon RDS DB instance only if a snapshot ID is provided."},
    \       { "word": "AWS::Region" ,  "info": "Returns a string representing the AWS Region in which the encompassing resource is being created "},
    \       { "word": "AWS::StackId" ,  "info": "Returns the ID of the stack as specified with the aws cloudformation create-stack command."},
    \       { "word": "AWS::StackName" ,  "info": "Returns the name of the stack as specified with the aws cloudformation create-stack command. "},
    \       ],
    \ }

