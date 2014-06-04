simulation stack
initSimStackForFramelessBlock: startpc
	"The register receiver (he closure itself) and args are pushed by the closure value primitive(s)
	 and hence a frameless block has all arguments and copied values pushed to the stack.  However,
	 the method receiver (self) is put in the ReceiverResultRegister by the block entry."
	| desc |
	<var: #desc type: #'CogSimStackEntry *'>
	simSelf
		type: SSRegister;
		spilled: false;
		annotateUse: false;
		register: ReceiverResultReg.
	optStatus
		isReceiverResultRegLive: true;
		ssEntry: (self addressOf: simSelf).
	self assert: methodOrBlockNumTemps >= methodOrBlockNumArgs.
	self assert: self numRegArgs <= 2.
	0 to: methodOrBlockNumTemps - 1 do:
		[:i|
		desc := self simStackAt: i.
		desc
			type: SSBaseOffset;
			spilled: true;
			annotateUse: false;
			register: SPReg;
			offset: ((methodOrBlockNumTemps - i) * BytesPerWord);
			bcptr: startpc].
	simSpillBase := simStackPtr := methodOrBlockNumTemps - 1