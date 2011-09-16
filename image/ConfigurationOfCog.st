Deprecation raiseWarning: false.

"load the cog configuration"
Gofer new
    squeaksource: 'MetacelloRepository';
    package: 'ConfigurationOfCog';
    load.
    
"start loading all the cog sources"
(Smalltalk at: #ConfigurationOfCog) project latestVersion load.

"save the image and quit"
Smalltalk snapshot: true andQuit: true.
