translation
declareCVarsIn: cg
	cg addHeaderFile: '<ft2build.h>'.
	cg addHeaderFile: 'FT_TRUETYPE_TABLES_H'.
	cg addHeaderFile: 'FT_FREETYPE_H'.
	cg addHeaderFile: 'FT_OUTLINE_H'.
	cg var: 'library' declareC: 'FT_Library library'.
	cg var: 'errorCode' type: 'int'.