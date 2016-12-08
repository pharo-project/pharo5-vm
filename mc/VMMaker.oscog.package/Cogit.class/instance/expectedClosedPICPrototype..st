in-line cacheing
expectedClosedPICPrototype: cPIC
	"Use asserts to check if the ClosedPICPrototype is as expected from compileClosedPICPrototype,
	 and can be updated as required via rewriteCPICCaseAt:tag:objRef:target:.  If all asserts pass, answer
	 0, otherwise answer a bit mask identifying all the errors."
	"self disassembleFrom: methodZoneBase + (self sizeof: CogMethod) to: methodZoneBase + closedPICSize"
	<var: #cPIC type: #'CogMethod *'>
	| pc errors object classTag entryPoint |
	errors := 0.
	pc := cPIC asUnsignedInteger + firstCPICCaseOffset.
	"First jump is unconditional; subsequent ones are conditional"
	object := backEnd literalBeforeFollowingAddress: pc - backEnd jumpLongByteSize.
	(self asserta: object = self firstPrototypeMethodOop) ifFalse:
		[errors := 1].

	entryPoint := backEnd jumpLongTargetBeforeFollowingAddress: pc.
	(self asserta: entryPoint = (self cPICPrototypeCaseOffset + 16rCA5E10)) ifFalse:
		[errors := errors + 2].

	1 to: MaxCPICCases - 1 do:
		[:i | | methodObjPC classTagPC |
		pc := pc + cPICCaseSize.

		"verify information in case is as expected."
		methodObjPC := pc - backEnd jumpLongConditionalByteSize - backEnd cmpC32RTempByteSize.
		object := backEnd literalBeforeFollowingAddress: methodObjPC.
		(self asserta: object = (self subsequentPrototypeMethodOop+ i)) ifFalse:
			[errors := errors bitOr: 4].

		classTagPC := pc - backEnd jumpLongConditionalByteSize.
		classTag := backEnd literal32BeforeFollowingAddress: classTagPC.
		(self asserta: classTag = (16rBABE1F15 + i)) ifFalse:
			[errors := errors bitOr: 8].

		entryPoint := backEnd jumpLongConditionalTargetBeforeFollowingAddress: pc.
		(self asserta: entryPoint = (self cPICPrototypeCaseOffset + 16rCA5E10 + (i * 16))) ifFalse:
			[errors := errors bitOr: 16].

		"change case via rewriteCPICCaseAt:tag:objRef:target:"
		self rewriteCPICCaseAt: pc
			tag: (classTag bitXor: 16r5A5A5A5A)
			objRef: (object bitXor: 16rA5A5A5A5)
			target: (entryPoint bitXor: 16r55AA50). "don't xor least 4 bits to leave instruction alignment undisturbed"

		"verify information in case is as expected post update."
		object := backEnd literalBeforeFollowingAddress: methodObjPC.
		(self asserta: object = (self subsequentPrototypeMethodOop + i bitXor: 16rA5A5A5A5)) ifFalse:
			[errors := errors bitOr: 32].
		classTag := backEnd literal32BeforeFollowingAddress: classTagPC.
		(self asserta: classTag = (16rBABE1F15 + i bitXor: 16r5A5A5A5A)) ifFalse:
			[errors := errors bitOr: 64].
		entryPoint := backEnd jumpLongConditionalTargetBeforeFollowingAddress: pc.
		(self asserta: entryPoint = ((self cPICPrototypeCaseOffset + 16rCA5E10 + (i * 16)) bitXor: 16r55AA50)) ifFalse:
			[errors := errors bitOr: 128].

		"finally restore case to the original state"
		self rewriteCPICCaseAt: pc
			tag: (classTag bitXor: 16r5A5A5A5A)
			objRef: (object bitXor: 16rA5A5A5A5)
			target: (entryPoint bitXor: 16r55AA50)].

	entryPoint := backEnd jumpLongTargetBeforeFollowingAddress: pc + cPICEndSize - literalsManager endSizeOffset.
	(self asserta: entryPoint = (self cPICMissTrampolineFor: 0)) ifFalse:
		[errors := errors + 256].
	
	^errors