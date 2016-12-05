bytecode generator support
setMergeSimStackOf: fixup
	<var: #fixup type: #'BytecodeFixup *'>
	self moveVolatileSimStackEntriesToRegisters.
	fixup mergeSimStack
		ifNil:
			[self assert: nextFixup <= numFixups.
			 self cCode: [fixup mergeSimStack: mergeSimStacksBase + (nextFixup * self simStackSlots * (self sizeof: CogSimStackEntry))].
			 nextFixup := nextFixup + 1]
		ifNotNil:
			[self assert: fixup simStackPtr = simStackPtr.
			 0 to: simStackPtr do:
				[:i|
				self assert: ((self simStackAt: i) isSameEntryAs: (fixup mergeSimStack at: i)).
				(self simStackAt: i) liveRegister ~= (fixup mergeSimStack at: i) liveRegister ifTrue:
					[(self simStackAt: i) liveRegister: NoReg]]].
	fixup
		simStackPtr: simStackPtr;
		isReceiverResultRegSelf: optStatus isReceiverResultRegLive.
	self cCode: [self mem: fixup mergeSimStack cp: simStack y: self simStackSlots * (self sizeof: CogSimStackEntry)]
		inSmalltalk: [fixup mergeSimStack: self copySimStack]