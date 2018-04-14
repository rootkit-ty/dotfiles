# aws-vim
Plugin acts as a completion helper for Cloud Formation Templates, and provides
some basic syntax highlighting to help those tasked with reading templates.

Currently this is a very early version; use it at your own risk.

## Installation

Use your plugin manager of choice.

- [Pathogen](https://github.com/tpope/vim-pathogen)
  - `git clone https://github.com/m-kat/aws-vim ~/.vim/bundle/aws-vim`
- [Vundle](https://github.com/gmarik/vundle)
  - Add `Bundle 'https://github.com/m-kat/aws-vim'` to .vimrc
  - Run `:BundleInstall`
- [NeoBundle](https://github.com/Shougo/neobundle.vim)
  - Add `NeoBundle 'https://github.com/m-kat/aws-vim'` to .vimrc
  - Run `:NeoBundleInstall`
- [vim-plug](https://github.com/junegunn/vim-plug)
  - Add `Plug 'https://github.com/m-kat/aws-vim'` to .vimrc
  - Run `:PlugInstall`

## Configuration
There are two major configuration parameters that you could add to your vimrc file:

* put **let g:AWSVimValidate = 1** to have a prototype of document validation whenever you try
    to write the document. The same functionality you can map with a **call AWSValidate()** function
* if you use the **ultisnips** plugin you can add a folder *snips* from aws-vim folder to the variable
    **g:UltiSnipsSnippetDirectories** for example:
        let g:UltiSnipsSnippetDirectories=["UltiSnips", "./bundle/aws-vim/snips"]
  In order to get the snippets completion (it works when no " sign is in line and the completion occurs on first element on that line)
  If the snippets are connected to my snippets, please add the following line to your .vimrc file in order to get it work:
    let g:AWSSnips = "Alarm Authentication Base64 CreationPolicy FindInMap GetAtt Init Instance InstanceProfile Join LaunchConfiguration LoadBalancer Param Policy RDSIngress Ref Role SGEgress SGIngress ScalingPolicy ScheduledAction SecurityGroup Select Stack Subnet VPC Volume VolumeAttachment WaitCondition WaitConditionHandle asg cft init_command init_file init_group init_user"

## Usage

Plugin registers files with extension **template** as files of type **"aws.json"**.
It is done that way, because the plugin itself doesn't expose the syntax colouring functionality.
If you use any plugin for json colouring then it will work with the CloudFormation Template files.

By default plugin uses vim user completion, so you can execute completion by simply use the combination
**<Ctrl+x><Ctrl+u>** in insert mode.

**IMPORTANT**
The plugin works only when the document is well formed. If there are some bugs in the document, the plugin may
not work at all or show incorect completions. Before posting an error please validate the json structure of your
document.

What currently **seems** to be working:
---------------------------------------

* Completion of attributes in objects in **Parameters** section (like Type, Default, NoEcho etc)
* Completion of kind of types in objects in **Parameters** section
* Completion of attributes in objects in **Resource** section ( with help downloaded from source aws documentation )
* Completion of properties in objects in **Resource** section
* Completion of kind of types in objects in **Resource** section
* Completion of parameters in **stack** objects in **Resource** section ( but the same conditions must be fulfilled as by **Fn::GetAtt**
            intrinistic function, please look below )
* Completion of **Ref** intrinistic function attribute
* Completion of **Fn::GetAtt** intrinistic function attribute ( when used against stacked template, two conditions must be
            fullfiled: the file to which the stack object refers must be located inside the folder in which the current template exists,
            the **TemplateUrl** attribute must be written in one line wiith its coresponding value, the file name of the template must be
            written as part of url or as a last string argument of a Fn::Join method )
* Completion of properties in objects in **Outputs** section

What is planned in near feature to correct/implement:
----------------------------------------------------

* Completion of **Conditions** section ( logical functions )
* Completion of parameters of **Fn::FindInMap** intrinistic function
* Validation of the template document
* Automatically updates of attributes from the documentation

Plugins that I utilize in order to improve editing of Cloud Formation Templates
-------------------------------------------------------------------------------
* elzr/vim-json for json colouring and also showing wrongly formatted code
* jiangmiao/auto-pairs for auto-pairing brackets, braces etc
* SirVer/ultisnips for snippets usage
