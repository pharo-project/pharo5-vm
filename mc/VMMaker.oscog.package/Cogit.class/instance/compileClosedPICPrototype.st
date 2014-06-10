in-line cacheing
compileClosedPICPrototype
	"Compile the abstract instructions for a full closed PIC used to initialize closedPICSize.
	 The loads into SendNumArgsReg are those for optional method objects which may be
	 used in MNU cases."
	| numArgs jumpNext |
	<var: #jumpNext type: #'AbstractInstruction *'>
	numArgs := 0.
	self compilePICProlog: numArgs.
	jumpNext := self compileCPICEntry.
	self MoveCw: 16r5EAF00D R: SendNumArgsReg.
	self JumpLong: 16r5EEDCA5E.
	jumpNext jmpTarget: (endCPICCase0 := self Label).
	1 to: numPICCases - 1 do:
		[:h|
		self CmpCw: 16rBABE1F15+h R: TempReg.
		self MoveCw: 16rBADA550 + h R: SendNumArgsReg.
		self JumpLongZero: 16rBEDCA5E0.
		h = 1 ifTrue:
			[endCPICCase1 := self Label]].
	self MoveCw: 16rAB5CE55 R: ClassReg.
	self JumpLong: (self cPICMissTrampolineFor: numArgs).
	^0