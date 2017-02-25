bytecode generator support
genSend: selectorIndex numArgs: numArgs
	"Generate an unlinked send.  Allow the objectRepresentation to inline if it can."
	| inlined |
	inlined := objectRepresentation
				maybeInlineSendOf: selectorIndex
				numArgs: numArgs
				receiverTags: receiverTags.
	inlined ifTrue:
		[self annotateInstructionForBytecode.
		 ^0].
	self marshallSendArguments: numArgs.
	^self genMarshalledSend: selectorIndex numArgs: numArgs sendTable: ordinarySendTrampolines