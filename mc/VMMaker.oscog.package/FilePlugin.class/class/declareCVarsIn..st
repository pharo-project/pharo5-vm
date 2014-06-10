translation
declareCVarsIn: aCCodeGenerator

	aCCodeGenerator var: 'sCCPfn'	type: 'void *'.
	aCCodeGenerator var: 'sCDPfn'	type: 'void *'.
	aCCodeGenerator var: 'sCGFTfn'	type: 'void *'.
	aCCodeGenerator var: 'sCLPfn'	type: 'void *'.
	aCCodeGenerator var: 'sCSFTfn'	type: 'void *'.
	aCCodeGenerator var: 'sDFAfn'	type: 'void *'.
	aCCodeGenerator var: 'sCDFfn'	type: 'void *'.
	aCCodeGenerator var: 'sCOFfn'	type: 'void *'.
	aCCodeGenerator var: 'sCRFfn'	type: 'void *'.
	aCCodeGenerator var: 'sHFAfn'	type: 'void *'.
	aCCodeGenerator addHeaderFile: '"FilePlugin.h"'