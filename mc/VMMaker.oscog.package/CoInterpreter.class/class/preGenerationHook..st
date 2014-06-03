translation
preGenerationHook: aCCodeGenerator
	"Override to undo the hiding of primitiveClosureValueNoContextSwitch"
	super preGenerationHook: aCCodeGenerator.
	(aCCodeGenerator methodNamed: #primitiveClosureValueNoContextSwitch) static: false