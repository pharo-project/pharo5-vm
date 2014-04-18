plugin extra rules
configureSDL2DisplayPlugin: maker
	"extra rules for SDL2DisplayPlugin"

	maker addExternalLibraries: #( 'SDL2' ).
	
	maker addCrossSources:
		#( 'SDL2DisplayPluginImpl.c').
