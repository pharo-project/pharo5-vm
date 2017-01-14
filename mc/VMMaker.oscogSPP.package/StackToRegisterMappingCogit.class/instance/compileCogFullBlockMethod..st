compile abstract instructions
compileCogFullBlockMethod: numCopied
	<option: #SistaV1BytecodeSet>
	methodOrBlockNumTemps := coInterpreter tempCountOf: methodObj.
	self cCode: '' inSmalltalk:
		[debugStackPointers := coInterpreter debugStackPointersFor: methodObj].
	^super compileCogFullBlockMethod: numCopied