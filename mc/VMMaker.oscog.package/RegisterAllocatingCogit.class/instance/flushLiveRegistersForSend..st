bytecode generator support
flushLiveRegistersForSend: numArgs
	<inline: true>
	simSelf liveRegister: NoReg.
	0 to: simStackPtr - numArgs - 1 do:
		[:i|
		 self assert: (self simStackAt: i) type = (i < methodOrBlockNumTemps
													ifTrue: [SSBaseOffset]
													ifFalse: [SSSpill]).
		 (self simStackAt: i) liveRegister: NoReg]