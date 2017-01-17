simulation stack
restoreSimStackAtMergePoint: fixup
	<inline: true>
	"All the execution paths reaching a merge point expect everything to be spilled
	 on stack and the optStatus is unknown.  If the merge point follows a return, it
	 isn't a merge, but a skip past a return.  If it is a real merge point then throw
	 away all simStack and optStatus optimization state."
	simSelf liveRegister: ((optStatus isReceiverResultRegLive: fixup isReceiverResultRegSelf)
							ifTrue: [ReceiverResultReg]
							ifFalse: [NoReg]).
	fixup mergeSimStack ifNotNil:
		[simSpillBase := methodOrBlockNumTemps.
		 0 to: simStackPtr do:
			[:i|
			self cCode: [simStack at: i put: (fixup mergeSimStack at: i)]
				inSmalltalk: [(simStack at: i) copyFrom: (fixup mergeSimStack at: i)]]].
	^0