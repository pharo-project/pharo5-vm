compile abstract instructions
compileCogMethod: selector
	methodOrBlockNumTemps := coInterpreter tempCountOf: methodObj.
	self cCode: '' inSmalltalk:
		[debugStackPointers := coInterpreter debugStackPointersFor: methodObj].
	^super compileCogMethod: selector