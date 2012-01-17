Deprecation raiseWarning: false.

"load the cog configuration"
Gofer new
    squeaksource: 'MetacelloRepository';
    package: 'ConfigurationOfCog';
    load.
    
"start loading all the cog sources"
(Smalltalk at: #ConfigurationOfCog) load.

"Open workspace with example Configurations"
Workspace openContents: (String streamContents: [ :stream|
        stream << '"Configuration for OSX"'; cr.
        stream << 'CogMacOSConfig generateWithSources.'; cr; cr.

        stream << '"Configuration for Linux"'; cr.
        stream << 'CogUnixConfig generateWithSources.'; cr; cr.

        stream << '"Configuration for Windows"'; cr.
        stream << 'CogWindowsConfig generateWithSources.'.
    ]).

"save the image and quit"
Smalltalk snapshot: true andQuit: true.

