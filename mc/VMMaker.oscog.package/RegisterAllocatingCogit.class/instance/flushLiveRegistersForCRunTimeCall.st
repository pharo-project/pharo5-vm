bytecode generator support
flushLiveRegistersForCRunTimeCall
	<inline: true>
	| reg |
	self assert: simSelf type = SSBaseOffset.
	reg := simSelf liveRegister.
	(reg ~= NoReg and: [(self isCallerSavedReg: reg)]) ifTrue:
		[simSelf liveRegister: NoReg].
	0 to: simStackPtr do:
		[:i|
		 self assert: (self simStackAt: i) type = (i <= methodOrBlockNumTemps
													ifTrue: [SSBaseOffset]
													ifFalse: [SSSpill]).
		 reg := (self simStackAt: i) liveRegister.
		 (reg ~= NoReg and: [(self isCallerSavedReg: reg)]) ifTrue:
			[(self simStackAt: i) liveRegister: NoReg]]