in-line cacheing
expectedClosedPICPrototype: cPIC
	"Answer 0 if the ClosedPIC is as expected from compileClosedPICPrototype,
	 otherwise answer an error code identifying the first discrepancy found."
	"self disassembleFrom: methodZoneBase + (self sizeof: CogMethod) to: methodZoneBase + closedPICSize"
	<var: #cPIC type: #'CogMethod *'>
	| pc object entryPoint |
	pc := cPIC asUnsignedInteger + firstCPICCaseOffset.
	"First jump is unconditional; subsequent ones are conditional"
	object := backEnd literalBeforeFollowingAddress: pc - backEnd jumpLongByteSize.
	self assert: object = 16r5EAF00D.

	entryPoint := backEnd jumpLongTargetBeforeFollowingAddress: pc.
	self assert: entryPoint = (self cPICPrototypeCaseOffset + 16rCA5E10).

	1 to: maxCPICCases - 1 do:
		[:i | | methodObjPC classTagPC |
		pc := pc + cPICCaseSize.

		methodObjPC := pc - backEnd jumpLongConditionalByteSize - backEnd cmpC32RTempByteSize.
		object := backEnd literalBeforeFollowingAddress: methodObjPC.
		self assert: object = (16rBADA550 + i).
		backEnd storeLiteral: (object bitXor: 16rA5A5A5A5) beforeFollowingAddress: methodObjPC.
		object := backEnd literalBeforeFollowingAddress: methodObjPC.
		self assert: object = (16rBADA550 + i bitXor: 16rA5A5A5A5).
		backEnd storeLiteral: (object bitXor: 16rA5A5A5A5) beforeFollowingAddress: methodObjPC.

		classTagPC := pc - backEnd jumpLongConditionalByteSize.
		object := backEnd literal32BeforeFollowingAddress: classTagPC.
		self assert: object = (16rBABE1F15 + i).
		backEnd storeLiteral: (object bitXor: 16r5A5A5A5A) beforeFollowingAddress: classTagPC.
		object := backEnd literal32BeforeFollowingAddress: classTagPC.
		self assert: object = (16rBABE1F15 + i bitXor: 16r5A5A5A5A).
		backEnd storeLiteral: (object bitXor: 16r5A5A5A5A) beforeFollowingAddress: classTagPC.

		entryPoint := backEnd jumpLongConditionalTargetBeforeFollowingAddress: pc.
		self assert: entryPoint = (self cPICPrototypeCaseOffset + 16rCA5E10 + (i * 16))].

	entryPoint := backEnd jumpLongTargetBeforeFollowingAddress: pc + cPICEndSize - literalsManager endSizeOffset.
	self assert: entryPoint = (self cPICMissTrampolineFor: 0).
	
	^0