internal interpreter access
is: fieldIndex methodAssignmentToContextWithMachineCodePC: anOop
	"If the method is assigned, any machine code pc must be mapped to a bytecode one
	 before the method is changed."
	<inline: true>
	| thePC |
	^fieldIndex = MethodIndex
	  and: [(thePC := objectMemory fetchPointer: InstructionPointerIndex ofObject: anOop) signedIntFromLong < 0
	  and: [objectMemory isIntegerObject: thePC]]