in-line cacheing
compileMNUCPIC: cPIC methodOperand: methodOperand numArgs: numArgs
	"Compile the code for a one-case MNU PIC that calls ceMNUFromPIC for case0Tag
	 The tag for case0 is at the send site and so doesn't need to be generated."
	<var: #cPIC type: #'CogMethod *'>
	| jumpNext |
	<var: #jumpNext type: #'AbstractInstruction *'>
	self compilePICProlog: numArgs.
	jumpNext := self compileCPICEntry.
	self MoveCw: methodOperand R: SendNumArgsReg.
	self JumpLong: mnuCall asInteger.
	jumpNext jmpTarget: (self MoveCw: cPIC asInteger R: ClassReg).
	self JumpLong: (self cPICMissTrampolineFor: numArgs).
	^0
