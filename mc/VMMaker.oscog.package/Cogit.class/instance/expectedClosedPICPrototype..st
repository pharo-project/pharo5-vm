in-line cacheing
expectedClosedPICPrototype: cPIC
	"Answer 0 if the ClosedPIC is as expected from compileClosedPICPrototype,
	 otherwise answer an error code identifying the first discrepancy found."
	"self disassembleFrom: methodZoneBase + (self sizeof: CogMethod) to: methodZoneBase + closedPICSize"
	<var: #cPIC type: #'CogMethod *'>
	| pc offsetToLiteral object entryPoint |
	pc := cPIC asInteger + firstCPICCaseOffset.
	"First jump is unconditional; subsequent ones are conditional"
	offsetToLiteral := backEnd jumpLongByteSize.
	
	object := literalsManager objRefInClosedPICAt: pc - offsetToLiteral.
	self assert: (object = 16r5EAF00D).

	entryPoint := backEnd jumpLongTargetBeforeFollowingAddress: pc.
	self assert: (entryPoint = (self cPICPrototypeCaseOffset + 16rCA5E10)).

	1 to: maxCPICCases - 1 do:
		[:i |
		pc := pc + cPICCaseSize.
		offsetToLiteral := backEnd jumpLongConditionalByteSize.

		object := literalsManager classRefInClosedPICAt: pc - offsetToLiteral.
		self assert: object = (16rBABE1F15 + i).
		literalsManager storeClassRef: (object bitXor: 16r5A5A5A5A) inClosedPICAt: pc - offsetToLiteral.
		object := literalsManager classRefInClosedPICAt: pc - offsetToLiteral.
		self assert: object = ((16rBABE1F15 + i bitXor: 16r5A5A5A5A)).
		literalsManager storeClassRef: (object bitXor: 16r5A5A5A5A) inClosedPICAt: pc - offsetToLiteral.

		object := literalsManager objRefInClosedPICAt: pc - offsetToLiteral.
		self assert: object = (16rBADA550 + i).
		literalsManager storeObjRef: (object bitXor: 16rA5A5A5A5) inClosedPICAt: pc - offsetToLiteral.
		object := literalsManager objRefInClosedPICAt: pc - offsetToLiteral.
		self assert: object = ((16rBADA550 + i) bitXor: 16rA5A5A5A5).
		literalsManager storeObjRef: (object bitXor: 16rA5A5A5A5) inClosedPICAt: pc - offsetToLiteral.

		entryPoint := backEnd jumpLongConditionalTargetBeforeFollowingAddress: pc.
		self assert: entryPoint = (self cPICPrototypeCaseOffset + 16rCA5E10 + (i * 16))].

	entryPoint := backEnd jumpLongTargetBeforeFollowingAddress: pc + cPICEndSize - literalsManager endSizeOffset.
	self assert: (entryPoint = (self cPICMissTrampolineFor: 0)).
	
	^0