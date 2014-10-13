plugin extra rules
configureX11DisplayPlugin: maker
	"extra rules for X11DisplayPlugin"

	maker addExternalLibraries: #( 'X11' ).
	
	maker addCrossSources:
		#( 'X11DisplayPluginImpl.c').
