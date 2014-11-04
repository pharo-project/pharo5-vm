bytecode generators
genSendAbsentImplicit: selector numArgs: numArgs
	"Get the implicit receiver and shuffle arguments if necessary.
	 Then send."
	<inline: false>
	| result |
	result := self genGetImplicitReceiverFor: selector forPush: false.
	result ~= 0 ifTrue:
		[^result].
	self marshallAbsentReceiverSendArguments: numArgs.
	^self genSend: selector numArgs: numArgs