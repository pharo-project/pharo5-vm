bytecode generator support
flushLiveRegistersForCRunTimeCall
	"Flush any live registers for a C call, i.e. don't flush caller-saved registers.
	 Answer if any registers were flushed."
	<inline: true>
	| flushed reg |
	flushed := false.
	self assert: simSelf type = SSBaseOffset.
	reg := simSelf liveRegister.
	(reg ~= NoReg and: [(self isCallerSavedReg: reg)]) ifTrue:
		[simSelf liveRegister: NoReg.
		 flushed := true].
	0 to: simStackPtr do:
		[:i|
		 self assert: (self simStackAt: i) type = (i < methodOrBlockNumTemps
													ifTrue: [SSBaseOffset]
													ifFalse: [SSSpill]).
		 reg := (self simStackAt: i) liveRegister.
		 (reg ~= NoReg and: [(self isCallerSavedReg: reg)]) ifTrue:
			[(self simStackAt: i) liveRegister: NoReg.
			 flushed := true]].
	^flushed