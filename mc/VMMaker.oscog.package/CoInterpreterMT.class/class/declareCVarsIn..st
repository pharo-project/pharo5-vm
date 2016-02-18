translation
declareCVarsIn: aCCodeGenerator
	aCCodeGenerator
		addHeaderFile:'"sqAtomicOps.h"'. "For THRLOG"
	aCCodeGenerator vmClass
		declareInterpreterVersionIn: aCCodeGenerator
		defaultName: 'Cog MT'.
	aCCodeGenerator
		var: #disowningVMThread type: #'CogVMThread *'