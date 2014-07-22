plugin extra rules
configureSDL2DisplayPlugin: maker
	"extra rules for SDL2DisplayPlugin"
	| lib |
	
	lib := self addThirdpartyLibrary: 'libsdl2'.
	maker 
		addExternalLibrary: lib targetForLinking;
		includeDirectories: lib includeDir;
		addCrossSources: #('SDL2DisplayPluginImpl.c')