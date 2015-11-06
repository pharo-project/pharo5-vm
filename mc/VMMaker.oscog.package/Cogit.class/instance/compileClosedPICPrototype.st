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
	jumpNext := self compileCPICEntry. "at the end of the entry code we need to jump to the first case code, which is actually the last chunk - for each entension we must update this jump to move back one case"
	self MoveUniqueCw: 16r5EAF00D R: SendNumArgsReg.
	self JumpLong: self cPICPrototypeCaseOffset + 16rCA5E10.
	endCPICCase0 := self Label.
	1 to: maxCPICCases - 1 do:
		[:h|
		h = (maxCPICCases - 1)
				ifTrue: [jumpNext jmpTarget: self Label]. "this is where we jump to for the first case"
		self CmpCw: 16rBABE1F15+h R: TempReg.
		self MoveUniqueCw: 16rBADA550 + h R: SendNumArgsReg.
		self JumpLongZero: self cPICPrototypeCaseOffset + 16rCA5E10 + (h * 16).
		h =  1 ifTrue:
			[endCPICCase1 := self Label]].
	self MoveCw: methodLabel address R: ClassReg.
	self JumpLong: (self cPICMissTrampolineFor: numArgs).
	cPICEndOfCodeLabel := self Label.
	literalsManager dumpLiterals: false.
	^0