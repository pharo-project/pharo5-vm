translation
declareCVarsIn: aCCodeGenerator
	"Note: This method must be implemented by all subclasses to declare variables."

	aCCodeGenerator 
		var: #interpreterProxy 
		type: #'struct VirtualMachine*'.
	self declareHeaderFilesIn: aCCodeGenerator.