message sending
createActualMessageTo: aClass 
	"Bundle up the selector, arguments and lookupClass into a Message object. 
	In the process it pops the arguments off the stack, and pushes the message object. 
	This can then be presented as the argument of e.g. #doesNotUnderstand:."
	"remap lookupClass in case GC happens during allocation"
	| argumentArray message lookupClass |
	<inline: false> "This is a useful break-point"
	self pushRemappableOop: aClass.
	argumentArray := self instantiateClass: (self splObj: ClassArray) indexableSize: argumentCount.
	"remap argumentArray in case GC happens during allocation"
	self pushRemappableOop: argumentArray.
	message := self instantiateClass: (self splObj: ClassMessage) indexableSize: 0.
	argumentArray := self popRemappableOop.
	lookupClass := self popRemappableOop.
	self beRootIfOld: argumentArray.

	self transfer: argumentCount from: stackPointer - (argumentCount - 1 * BytesPerWord) to: argumentArray + BaseHeaderSize.
	self pop: argumentCount thenPush: message.

	argumentCount := 1.
	self storePointerUnchecked: MessageSelectorIndex ofObject: message withValue: messageSelector.
	self storePointerUnchecked: MessageArgumentsIndex ofObject: message withValue: argumentArray.
	self storePointerUnchecked: MessageLookupClassIndex ofObject: message withValue: lookupClass