in-line cacheing
compileClosedPICPrototype
	"Compile the abstract instructions for a full closed PIC used to initialize closedPICSize.
	 The loads into SendNumArgsReg are those for optional method objects which may be
	 used in MNU cases."
	<inline: true>
	| numArgs jumpNext |
	<var: #jumpNext type: #'AbstractInstruction *'>
	numArgs := 0.
	self compilePICAbort: numArgs.
	jumpNext := self compileCPICEntry.
	self MoveCw: 16r5EAF00D R: SendNumArgsReg.
	self DumpJumpLong: methodZoneBase + 16rCA5E10.
	jumpNext jmpTarget: (endCPICCase0 := self Label).
	1 to: numPICCases - 1 do:
		[:h|
		self CmpCw: 16rBABE1F15+h R: TempReg.
		self MoveCw: 16rBADA550 + h R: SendNumArgsReg.
		self DumpJumpLongZero: 16rCA5E10 + (h * 16).
		h = 1 ifTrue:
			[endCPICCase1 := self Label]].
	self MoveCw: methodLabel address R: ClassReg.
	self JumpLong: (self cPICMissTrampolineFor: numArgs).
	^0