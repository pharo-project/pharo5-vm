frame access
contextInstructionPointer: mcpc context: aContext
	"Answer a value to store in the InstructionPointer index of a context object for mcpc.
	 This is needed for cannotReturn: where we have the instructionPointer, the context
	 but not the cog method, and so don't know which method or block we're in.  Find it."
	<inline: false>
	| methodObj homeMethod cogMethod |
	<var: #homeMethod type: #'CogMethod *'>
	<var: #cogMethod type: #'CogBlockMethod *'>
	methodObj := objectMemory fetchPointer: MethodIndex ofObject: aContext.
	self assert: (self methodHasCogMethod: methodObj).
	homeMethod := self cogMethodOf: methodObj.
	cogMethod := cogit findEnclosingMethodFor: mcpc inHomeMethod: homeMethod.
	self assert: (cogMethod cmType = CMBlock)
				= ((objectMemory fetchPointer: ClosureIndex ofObject: aContext) ~= objectMemory nilObject).
	^self encodedNativePCOf: mcpc cogMethod: cogMethod