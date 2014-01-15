primitive support
roomToPushNArgs: n
	"Answer if there is room to push n arguments onto the current stack.
	 There may be room in this stackPage but there may not be room if
	 the frame were converted into a context."
	| methodHeader cntxSize |
	(self isMachineCodeFrame: framePointer)
		ifTrue: [methodHeader := (self mframeHomeMethod: framePointer) methodHeader]
		ifFalse: [methodHeader := self headerOf: (self iframeMethod: framePointer)].
	cntxSize := (methodHeader bitAnd: LargeContextBit) ~= 0
					ifTrue: [LargeContextSize / BytesPerWord - ReceiverIndex]
					ifFalse: [SmallContextSize / BytesPerWord - ReceiverIndex].
	^self stackPointerIndex + n <= cntxSize