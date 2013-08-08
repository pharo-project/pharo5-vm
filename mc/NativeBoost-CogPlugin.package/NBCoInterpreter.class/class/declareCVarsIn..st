as yet unclassified
declareCVarsIn: aCCodeGenerator
	super declareCVarsIn: aCCodeGenerator.
	
	"make it public, need for Callbacks support code"
	aCCodeGenerator
		var: #reenterInterpreter
		declareC: 'jmp_buf reenterInterpreter'.
