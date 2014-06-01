plugin extra rules
configureSDL2DisplayPlugin: maker
	"extra rules for SDL2DisplayPlugin"
	| lib |
	
	lib := self addThirdpartyLibrary: 'SDL2'.

	"link plugin with freetype lib"
	maker addExternalLibrary: lib targetForLinking.
	maker includeDirectories: lib includeDir.
	
	maker addCrossSources:
		#( 'SDL2DisplayPluginImpl.c').
