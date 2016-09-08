message sending
handleForwardedSendFaultForTag: classTag
	"Handle a send fault that may be due to a send to a forwarded object.
	 Unforward the receiver on the stack and answer its actual class."
	<option: #SpurObjectMemory>
	| rcvr |
	<inline: false>
	self assert: (objectMemory isForwardedClassTag: classTag).

	rcvr := self stackValue: argumentCount.
	"should *not* be a super send, so the receiver should be forwarded."
	self assert: (objectMemory isOopForwarded: rcvr).
	rcvr := objectMemory followForwarded: rcvr.
	self stackValue: argumentCount put: rcvr.
	self followForwardedFrameContents: framePointer
		stackPointer: stackPointer + (argumentCount + 1 * objectMemory wordSize). "don't repeat effort"
	(objectMemory isPointers: (self frameReceiver: framePointer)) ifTrue:
		[objectMemory
			followForwardedObjectFields: (self frameReceiver: framePointer)
			toDepth: 0].
	^objectMemory fetchClassTagOf: rcvr