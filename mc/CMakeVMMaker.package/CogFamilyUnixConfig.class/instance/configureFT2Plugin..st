plugin extra rules
configureFT2Plugin: maker 
	"extra rules for FT2Plugin" 
	
	maker addExternalLibraries: #('freetype' ).
	
	"
	ft2build.h. says: 
	<prefix>/include/freetype2' must be in your current inclusion path "
	maker includeDirectories:  '/usr/include/freetype2'