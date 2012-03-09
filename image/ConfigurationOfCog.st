Deprecation raiseWarning: false.

"load the cog configuration"
Gofer new
	squeaksource: 'PharoVM';
	package: 'ConfigurationOfPharoVM';
	load.
	
"start loading all the cog sources"
(Smalltalk at: #ConfigurationOfPharoVM) load.

"Open workspace with example Configurations"
Workspace openContents: (String streamContents: [ :stream|
        stream << '"Configuration for OSX ---------------------------------------------------"'; cr.
        stream << 'CogCocoaIOSConfig new'; cr.
        stream << '    addExternalPlugins: #( FT2Plugin );'; cr.
        stream << '    generateSources; generate.'; cr; cr.

        stream << '"Configuration for Linux -------------------------------------------------"'; cr.
        stream << 'CogUnixConfig new'; cr.
        stream << '    addExternalPlugins: #( FT2Plugin );'; cr.
        stream << '    generateSources; generate.'; cr; cr.

        stream << '"Configuration for Windows -----------------------------------------------"'; cr.
        stream << 'CogWindowsConfig new'; cr.
        stream << '    addExternalPlugins: #( FT2Plugin );'; cr.
        stream << '    generateSources; generate.'; cr; cr.

        stream << '"A list of all plugins ---------------------------------------------------"'; cr.
        stream << '(SmartSyntaxInterpreterPlugin allSubclasses select: #shouldBeTranslated) inspect.'; cr.
        stream << '"Or send #internalPlugins or #externalPlugins" to the chosen onfiguration'.
    ]).

"save the image and quit"
Smalltalk snapshot: true andQuit: true.
