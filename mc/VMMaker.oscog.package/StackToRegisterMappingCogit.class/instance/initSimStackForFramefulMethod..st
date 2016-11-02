simulation stack
initSimStackForFramefulMethod: startpc
	<var: #desc type: #'CogSimStackEntry *'>
	simSelf
		type: SSBaseOffset;
		spilled: true;
		register: FPReg;
		offset: FoxMFReceiver.
	optStatus 
		isReceiverResultRegLive: false;
		ssEntry: (self addressOf: simSelf).
	simSpillBase := methodOrBlockNumTemps. "N.B. Includes num args"
	simStackPtr := simSpillBase - 1.
	LowcodeVM ifTrue: [
		simNativeSpillBase := simNativeStackPtr := -1.
		simNativeStackSize := 0.
	].
	"args"
	0 to: methodOrBlockNumArgs - 1 do:
		[:i| | desc |
		desc := self simStackAt: i.
		desc
			type: SSBaseOffset;
			spilled: true;
			register: FPReg;
			offset: FoxCallerSavedIP + ((methodOrBlockNumArgs - i) * objectMemory wordSize);
			bcptr: startpc].
	"temps"
	methodOrBlockNumArgs to: simStackPtr do:
		[:i| | desc |
		desc := self simStackAt: i.
		desc
			type: SSBaseOffset;
			spilled: true;
			register: FPReg;
			offset: FoxMFReceiver - (i - methodOrBlockNumArgs + 1 * objectMemory wordSize);
			bcptr: startpc]