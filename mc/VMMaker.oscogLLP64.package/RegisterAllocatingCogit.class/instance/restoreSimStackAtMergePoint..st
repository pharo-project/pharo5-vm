simulation stack
restoreSimStackAtMergePoint: fixup
	<inline: true>
	"All the execution paths reaching a merge point expect everything to be
	spilled on stack and the optStatus is unknown. Throw away all simStack and 
	optStatus optimization state."
	simSpillBase := methodOrBlockNumTemps.
	optStatus isReceiverResultRegLive: false.
	0 to: simStackPtr do:
		[:i|
		self cCode: [simStack at: i put: (fixup mergeSimStack at: i)]
			inSmalltalk: [(simStack at: i) copyFrom: (fixup mergeSimStack at: i)]].
	^ 0