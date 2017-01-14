simulation stack
initSimStackForFramelessMethod: startpc
	| desc |
	<var: #desc type: #'CogSimStackEntry *'>
	simSelf
		type: SSRegister;
		spilled: false;
		register: ReceiverResultReg.
	optStatus
		isReceiverResultRegLive: true;
		ssEntry: (self addressOf: simSelf).
	self assert: methodOrBlockNumTemps = methodOrBlockNumArgs.
	self assert: self numRegArgs <= 2.
	(methodOrBlockNumArgs between: 1 and: self numRegArgs)
		ifTrue:
			[desc := self simStackAt: 0.
			 desc
				type: SSRegister;
				spilled: false;
				register: Arg0Reg;
				bcptr: startpc.
			 methodOrBlockNumArgs > 1 ifTrue:
				[desc := self simStackAt: 1.
				 desc
					type: SSRegister;
					spilled: false;
					register: Arg1Reg;
					bcptr: startpc]]
		ifFalse:
			[0 to: methodOrBlockNumArgs - 1 do:
				[:i|
				desc := self simStackAt: i.
				desc
					type: SSBaseOffset;
					register: SPReg;
					spilled: true;
					offset: ((backEnd hasLinkRegister
								ifTrue: [methodOrBlockNumArgs - 1- i]
								ifFalse: [methodOrBlockNumArgs - i]) * objectMemory wordSize);
					bcptr: startpc]].
	simSpillBase := simStackPtr := methodOrBlockNumArgs - 1.
	LowcodeVM ifTrue: [
		simNativeSpillBase := simNativeStackPtr := -1.
		simNativeStackSize := 0.
	].