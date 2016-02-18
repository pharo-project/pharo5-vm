private
ftHandleValueFromReceiver: rcvrOop
	"this is the opposite of #ftAllocateHandleIn:forPointer: .
	It takes rcvr's first instance variable,
	which should be a ByteArray the size of a void*,
	and returns its value as a C pointer."

	| oop btw |
	self inline: false.

	self returnTypeC: 'void *'.
	oop := interpreterProxy fetchPointer: 0 ofObject: rcvrOop.
	
	interpreterProxy success:
		((interpreterProxy isBytes: oop) and:
		 [(interpreterProxy slotSizeOf: oop) = (self cCode: 'sizeof(void *)')]).
	interpreterProxy failed ifTrue: [^ nil].
	btw := 8. "self bytesPerWord"
	^self cCode:  '*(void**)(pointerForOop(oop + btw))'.
