simulation stack
restoreSimStackAtMergePoint: fixup
	<inline: true>
	"All the execution paths reaching a merge point expect everything to be spilled
	 on stack and the optStatus is unknown.  If the merge point follows a return, it
	 isn't a merge, but a sdkip past a return.  If it is a real merge point then throw
	 away all simStack and optStatus optimization state."
	fixup mergeSimStack ifNotNil:
		[simSpillBase := methodOrBlockNumTemps.
		 self flag: 'try and maintain this through the merge'.
		 optStatus isReceiverResultRegLive: false.
		 0 to: simStackPtr do:
			[:i|
			self cCode: [simStack at: i put: (fixup mergeSimStack at: i)]
				inSmalltalk: [(simStack at: i) copyFrom: (fixup mergeSimStack at: i)]]].
	^0