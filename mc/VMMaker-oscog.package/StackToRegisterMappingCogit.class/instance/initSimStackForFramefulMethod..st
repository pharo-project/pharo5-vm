simulation stack
initSimStackForFramefulMethod: startpc
	<var: #desc type: #'CogSimStackEntry *'>
	optStatus isReceiverResultRegLive: false.
	simSelf
		type: SSBaseOffset;
		spilled: true;
		annotateUse: false;
		register: FPReg;
		offset: FoxMFReceiver.
	simSpillBase := methodOrBlockNumTemps. "N.B. Includes num args"
	simStackPtr := simSpillBase - 1.
	"args"
	0 to: methodOrBlockNumArgs - 1 do:
		[:i| | desc |
		desc := self simStackAt: i.
		desc
			type: SSBaseOffset;
			spilled: true;
			annotateUse: false;
			register: FPReg;
			offset: FoxCallerSavedIP + ((methodOrBlockNumArgs - i) * BytesPerWord);
			bcptr: startpc].
	"temps"
	methodOrBlockNumArgs to: simStackPtr do:
		[:i| | desc |
		desc := self simStackAt: i.
		desc
			type: SSBaseOffset;
			spilled: true;
			annotateUse: false;
			register: FPReg;
			offset: FoxMFReceiver - (i - methodOrBlockNumArgs + 1 * BytesPerWord);
			bcptr: startpc]