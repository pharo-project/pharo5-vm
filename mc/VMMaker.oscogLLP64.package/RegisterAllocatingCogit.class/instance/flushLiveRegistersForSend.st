bytecode generator support
flushLiveRegistersForSend
	<inline: true>
	0 to: simStackPtr do:
		[:i|
		 self assert: (self simStackAt: i) type = (i <= methodOrBlockNumTemps
													ifTrue: [SSBaseOffset]
													ifFalse: [SSSpill]).
		 (self simStackAt: i) liveRegister: NoReg]