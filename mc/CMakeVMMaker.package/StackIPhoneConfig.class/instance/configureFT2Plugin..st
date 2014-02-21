plugin extra rules
configureFT2Plugin: maker
	"extra rules for Freetype plugin.
	a custom rule to build freetype library"
	| lib |

	"add freetype library into loop"
	lib := self addThirdpartyLibrary: 'freetype2'.
	lib configurationFlags: self ft2PluginConfigurationFlags.

	"link plugin with freetype lib"
	maker includeDirectories: lib includeDir. 
	maker addExternalLibrary: '${thirdpartyDir}/out/lib/', lib libraryFileName.
	maker addExternalDependency: 'freetype2'.
