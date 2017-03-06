simulation stack
freeAnyFloatRegNotConflictingWith: regMask
	"Spill the closest register on stack not conflicting with regMask. 
	Assertion Failure if regMask has already all the registers"
	<var: #desc type: #'CogSimStackEntry *'>
	| reg index |
	self assert: needsFrame.
	reg := NoReg.
	index := simSpillBase max: 0.
	LowcodeVM ifTrue: [
		index := simNativeSpillBase max: 0.
		[reg = NoReg and: [index < simNativeStackPtr]] whileTrue: 
			[ | desc |
			 desc := self simNativeStackAt: index.
			(desc type = SSRegisterSingleFloat or: [desc type = SSRegisterDoubleFloat]) ifTrue:
				[(regMask anyMask: (self registerMaskFor: desc register)) ifFalse: 
					[reg := desc register]].
			 index := index + 1].
	].
	self deny: reg = NoReg.
	self ssAllocateRequiredFloatReg: reg.
	^reg