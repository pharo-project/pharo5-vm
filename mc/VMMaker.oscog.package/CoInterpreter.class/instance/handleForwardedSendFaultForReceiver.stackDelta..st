message sending
handleForwardedSendFaultForReceiver: forwardedReceiver stackDelta: stackDelta
	"Handle a send fault that may be due to a send to a forwarded object.
	 Unforward the receiver on the stack and answer it."
	<option: #SpurObjectMemory>
	| rcvrStackIndex rcvr |
	<inline: false>
	"should *not* be a super send, so the receiver should be forwarded."
	self assert: (objectMemory isOopForwarded: forwardedReceiver).
	rcvrStackIndex := argumentCount + stackDelta.
	self assert: (self stackValue: rcvrStackIndex) = forwardedReceiver.
	rcvr := objectMemory followForwarded: forwardedReceiver.
	self stackValue: rcvrStackIndex put: rcvr.
	self followForwardedFrameContents: framePointer
		stackPointer: stackPointer + (rcvrStackIndex + 1 * objectMemory wordSize). "don't repeat effort"
	(objectMemory isPointers: (self frameReceiver: framePointer)) ifTrue:
		[objectMemory
			followForwardedObjectFields: (self frameReceiver: framePointer)
			toDepth: 0].
	self followForwardedFieldsInCurrentMethod.
	^rcvr