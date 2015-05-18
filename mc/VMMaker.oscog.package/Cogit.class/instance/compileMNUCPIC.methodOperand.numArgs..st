in-line cacheing
compileMNUCPIC: cPIC methodOperand: methodOperand numArgs: numArgs
	"Compile the code for a one-case MNU PIC that calls ceMNUFromPIC for case0Tag
	 The tag for case0 is at the send site and so doesn't need to be generated."
	<var: #cPIC type: #'CogMethod *'>
	| jumpNext operand |
	<var: #jumpNext type: #'AbstractInstruction *'>
	self compilePICAbort: numArgs.
	jumpNext := self compileCPICEntry.
	"We do not scavenge PICs, hence we cannot cache the MNU method if it is in new space."
	operand := (methodOperand isNil or: [objectMemory isYoungObject: methodOperand])
					ifTrue: [0]
					ifFalse: [methodOperand].
	self MoveCw: operand R: SendNumArgsReg.
	self JumpLong: picMNUAbort asInteger.
	jumpNext jmpTarget: (self MoveCw: cPIC asInteger R: ClassReg).
	self JumpLong: (self cPICMissTrampolineFor: numArgs).
	^0
