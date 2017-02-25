simulation only
ioLoadFunction: functionName From: moduleName
	"hack around the CoInterpreter/ObjectMemory split refactoring.
	 provide accurate types for the VMPluginCodeGenerator."
	<doNotGenerate>
	<returnTypeC: #'void *'>
	<var: #functionName type: #'char *'>
	<var: #moduleName type: #'char *'>
	^coInterpreter ioLoadFunction: functionName From: moduleName