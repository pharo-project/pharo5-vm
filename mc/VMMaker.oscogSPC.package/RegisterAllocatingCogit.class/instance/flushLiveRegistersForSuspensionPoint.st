bytecode generator support
flushLiveRegistersForSuspensionPoint
	"Flush any live registers for a C call at a suspension/resumption point, i.e.flush all registers.
	 Answer if any registers were flushed."
	<inline: true>
	| flushed |
	flushed := false.
	self assert: simSelf type = SSBaseOffset.
	simSelf liveRegister ~= NoReg ifTrue:
		[simSelf liveRegister: NoReg.
		 flushed := true].
	0 to: simStackPtr do:
		[:i|
		 self assert: (i < methodOrBlockNumTemps
						ifTrue: [(self simStackAt: i) type = SSBaseOffset]
						ifFalse: [(self simStackAt: i)  spilled]).
		 (self simStackAt: i) liveRegister ~= NoReg ifTrue:
			[(self simStackAt: i) liveRegister: NoReg.
			 flushed := true]].
	^flushed