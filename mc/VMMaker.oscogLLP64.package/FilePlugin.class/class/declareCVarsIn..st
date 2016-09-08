translation
declareCVarsIn: aCCodeGenerator

	self declareC:  #('sCCPfn' 'sCDFfn' 'sCDPfn' 'sCGFTfn' 'sCLPfn' 'sCOFfn' 'sCRFfn' 'sCSFTfn' 'sDFAfn' 'sHFAfn')
		as: #'void *'
		in: aCCodeGenerator.
	aCCodeGenerator addHeaderFile: '"FilePlugin.h"'