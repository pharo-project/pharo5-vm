translation
declareCVarsIn: aCCodeGenerator

	aCCodeGenerator var: 'sDSAfn'	type: 'void *'.
	aCCodeGenerator var: 'sHSAfn'	type: 'void *'.
	aCCodeGenerator var: 'sCCTPfn'	type: 'void *'.
	aCCodeGenerator var: 'sCCLOPfn'	type: 'void *'.
	aCCodeGenerator var: 'sCCSOTfn'	type: 'void *'.
	aCCodeGenerator addHeaderFile: '"SocketPlugin.h"'