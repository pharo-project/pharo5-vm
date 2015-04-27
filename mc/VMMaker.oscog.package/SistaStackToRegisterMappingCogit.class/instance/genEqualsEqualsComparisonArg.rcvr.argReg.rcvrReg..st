bytecode generators
genEqualsEqualsComparisonArg: unforwardArg rcvr: unforwardRcvr argReg: argReg rcvrReg: rcvrReg
	<inline: true>
	unforwardArg 
		ifFalse: [ self CmpCq: self ssTop constant R: rcvrReg ]
		ifTrue: [ unforwardRcvr
			ifFalse: [ self CmpCq: (self ssValue: 1) constant R: argReg ]
			ifTrue: [ self CmpR: argReg R: rcvrReg ] ].	 