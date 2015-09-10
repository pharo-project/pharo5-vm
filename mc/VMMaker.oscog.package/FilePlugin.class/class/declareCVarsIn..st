translation
declareCVarsIn: aCCodeGenerator

	self declareC:  #('sCCPfn' 'sCDFfn' 'sCDPfn' 'sCGFTfn' 'sCLPfn' 'sCOFfn' 'sCRFfn' 'sCSFTfn' 'sDFAfn' 'sHFAfn')
		as: #'void *'
		in: aCCodeGenerator.
	aCCodeGenerator
		const: #PharoVM
		declareC: ('#if !defined(PharoVM) /* Allow PharoVM to be overridden on the compiler command line */\# define PharoVM 0\#endif') withCRs.
	aCCodeGenerator addHeaderFile: '"FilePlugin.h"'