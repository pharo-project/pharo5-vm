plugin extra rules
configureDropPlugin: maker
	"extra rules for DropPlugin"
	super configureDropPlugin: maker.  
	maker includeDirectories: '${crossDir}/plugins/FilePlugin'. 
	maker addPlatformSources: #( 'sqUnixDragDrop')
