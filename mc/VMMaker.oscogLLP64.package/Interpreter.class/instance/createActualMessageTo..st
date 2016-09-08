message sending
createActualMessageTo: aClass 
	"Bundle up the selector, arguments and lookupClass into a Message object. 
	In the process it pops the arguments off the stack, and pushes the message object. 
	This can then be presented as the argument of e.g. #doesNotUnderstand:. 
	ikp 11/20/1999 03:59 -- added hook for external runtime compilers."
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

	compilerInitialized
		ifTrue: [self compilerCreateActualMessage: message storingArgs: argumentArray]
		ifFalse: [self transfer: argumentCount from: stackPointer - (argumentCount - 1 * self wordSize) to: argumentArray + self baseHeaderSize.
			self pop: argumentCount thenPush: message].

	argumentCount := 1.
	self storePointer: MessageSelectorIndex ofObject: message withValue: messageSelector.
	self storePointer: MessageArgumentsIndex ofObject: message withValue: argumentArray.
	(self lastPointerOf: message) >= (MessageLookupClassIndex * self wordSize + self baseHeaderSize)
		ifTrue: ["Only store lookupClass if message has 3 fields (old images don't)"
			self storePointer: MessageLookupClassIndex ofObject: message withValue: lookupClass]