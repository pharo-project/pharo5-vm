message sending
createActualMessageTo: lookupClass 
	"Bundle up the selector, arguments and lookupClass into a Message object. 
	 In the process it pops the arguments off the stack, and pushes the message object. 
	 This can then be presented as the argument of e.g. #doesNotUnderstand:"
	| argumentArray message |
	<inline: false> "This is a useful break-point"
	self assert: ((objectMemory isIntegerObject: messageSelector) or: [objectMemory addressCouldBeObj: messageSelector]).
	argumentArray := objectMemory eeInstantiateClass: (objectMemory splObj: ClassArray) indexableSize: argumentCount.
	message := objectMemory eeInstantiateClass: (objectMemory splObj: ClassMessage) indexableSize: 0.

	"Since the array is new can use unchecked stores."
	(argumentCount - 1) * BytesPerWord to: 0 by: BytesPerWord negated do:
		[:i|
		self longAt:  argumentArray + BaseHeaderSize + i put: self popStack].
	"Since message is new can use unchecked stores."
	objectMemory storePointerUnchecked: MessageSelectorIndex ofObject: message withValue: messageSelector.
	objectMemory storePointerUnchecked: MessageArgumentsIndex ofObject: message withValue: argumentArray.
	objectMemory storePointerUnchecked: MessageLookupClassIndex ofObject: message withValue: lookupClass.

	self push: message.

	argumentCount := 1.