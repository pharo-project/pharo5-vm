doits
fixFreeTypePluginForPharo

"this is obsolete, and no longer required"

(Smalltalk at:#FT2Plugin) class compile: 
	'declareCVarsIn: cg
	cg addHeaderFile: ''<ft2build.h>''.
	cg addHeaderFile: ''<freetype/tttables.h>''.
	cg addHeaderFile: ''FT_FREETYPE_H''.
	cg addHeaderFile: ''FT_OUTLINE_H''.
	cg var: ''library'' declareC: ''FT_Library library''.
	cg var: ''errorCode'' type: ''int''.'