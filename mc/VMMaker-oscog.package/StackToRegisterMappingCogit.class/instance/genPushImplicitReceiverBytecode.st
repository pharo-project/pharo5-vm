bytecode generators
genPushImplicitReceiverBytecode
	| result |
	result := self genGetImplicitReceiverFor: (self getLiteral: byte1) forPush: true.
	result ~= 0 ifTrue:
		[^result].
	^self ssPushRegister: ReceiverResultReg