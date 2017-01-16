generate machine code
concretizeXorRdRd
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| regLHS regRHS skip |
	regRHS := self operands at: 0.
	regLHS := self operands at: 1.
	machineCode
		at: 0 put: 16r66.
	(regLHS <= 7 and: [regRHS <= 7])
		ifTrue: [skip := 0]
		ifFalse: [machineCode at: (skip := 1) put: (self rexw: false r: regLHS x: 0 b: regRHS)].
	machineCode
		at: skip + 1 put: 16r0f;
		at: skip + 2 put: 16r57;
		at: skip + 3 put: (self mod: ModReg RM: regRHS RO: regLHS).
	^machineCodeSize := skip + 4