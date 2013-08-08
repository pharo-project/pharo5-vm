plugin extra rules
configureFT2Plugin: maker
	"extra rules for Freetype plugin.
	a custom rule to build freetype library"
	| lib |
	
"	maker isExternal ifFalse: [
		self error: 'building internal FT2Plugin is not supported yet'  	
	].
"
	"add freetype library into loop"
	lib := self addThirdpartyLibrary: 'freetype2'.

	"link plugin with freetype lib"
	maker addExternalLibrary: lib targetForLinking.
	maker includeDirectories: lib includeDir.

