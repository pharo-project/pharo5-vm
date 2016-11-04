simulation stack
initSimStackForFramelessBlock: startpc
	"The register receiver (the closure itself) and args are pushed by the closure value primitive(s)
	 and hence a frameless block has all arguments and copied values pushed to the stack.  However,
	 the method receiver (self) is put in the ReceiverResultRegister by the block entry."
	| desc |
	<var: #desc type: #'CogSimStackEntry *'>
	simSelf
		type: SSRegister;
		spilled: false;
		register: ReceiverResultReg.
	optStatus
		isReceiverResultRegLive: true;
		ssEntry: (self addressOf: simSelf).
	self assert: methodOrBlockNumTemps >= methodOrBlockNumArgs.
	0 to: methodOrBlockNumTemps - 1 do:
		[:i|
		desc := self simStackAt: i.
		desc
			type: SSBaseOffset;
			spilled: true;
			register: SPReg;
			offset: ((backEnd hasLinkRegister
								ifTrue: [methodOrBlockNumArgs - 1- i]
								ifFalse: [methodOrBlockNumArgs - i]) * objectMemory wordSize);
			bcptr: startpc].
	simSpillBase := simStackPtr := methodOrBlockNumTemps - 1.
	LowcodeVM ifTrue: [
		simNativeSpillBase := simNativeStackPtr := -1.
		simNativeStackSize := 0.
	].