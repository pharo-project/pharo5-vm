simulation stack
restoreSimStackAtMergePoint: fixup
	<inline: true>
	"All the execution paths reaching a merge point expect everything to be
	spilled on stack and the optStatus is unknown. Throw away all simStack and 
	optStatus optimization state."
	simSpillBase := methodOrBlockNumTemps.
	optStatus isReceiverResultRegLive: false.
	methodOrBlockNumTemps to: simStackPtr do:
		[:i|
			(self simStackAt: i)
				type: SSSpill;
				offset: FoxMFReceiver - (i - methodOrBlockNumArgs + 1 * objectMemory bytesPerOop);
				register: FPReg;
				spilled: true].
	LowcodeVM ifTrue: [
		0 to: simNativeStackPtr do: [ :i |
			(self simNativeStackAt: i)
				ensureIsMarkedAsSpilled
		].
		simNativeSpillBase := simNativeStackPtr + 1
	].
	^ 0