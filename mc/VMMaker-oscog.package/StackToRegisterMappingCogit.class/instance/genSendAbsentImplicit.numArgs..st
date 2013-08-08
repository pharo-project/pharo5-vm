bytecode generators
genSendAbsentImplicit: selector numArgs: numArgs
	"Get the implicit receiver and marshall arguments, shuffling the
	 stack to push the implicit receiver if necessary. Then send."
	<inline: false>
	| result |
	"This must not be PC-mapped"
	result := self genGetImplicitReceiverFor: selector forPush: false.
	result ~= 0 ifTrue:
		[^result].
	self marshallImplicitReceiverSendArguments: numArgs.
	^self genMarshalledSend: selector numArgs: numArgs