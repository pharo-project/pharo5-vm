translation
declareCVarsIn: aCCodeGenerator
	"Override to avoid repeating CoInterpreter's declarations and add our own extensions, if any."

	aCCodeGenerator
		addHeaderFile:'"sqAtomicOps.h"'. "For THRLOG"
	self declareInterpreterVersionIn: aCCodeGenerator
		defaultName: 'Cog MT'.
	aCCodeGenerator
		var: #disowningVMThread type: #'CogVMThread *'