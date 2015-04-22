simulation stack
freeAnyRegNotConflictingWith: regMask
	"Spill the closest register on stack not conflicting with regMask. 
	Assertion Failure if regMask has already all the registers"
	<var: #desc type: #'CogSimStackEntry *'>
	| reg index |
	index := simSpillBase max: 0.
	[reg isNil and: [index < simStackPtr] ] whileTrue: 
		[ | desc |
		 desc := self simStackAt: index.
		 desc type = SSRegister ifTrue:
			[ (regMask anyMask: (self registerMaskFor: desc register)) ifFalse: 
				[ reg := desc register ] ].
		 index := index + 1].
	self assert: reg notNil.
	self ssAllocateRequiredReg: reg.
	^reg