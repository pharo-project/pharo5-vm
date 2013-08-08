primitive support
roomToPushNArgs: n
	"Answer if there is room to push n arguments onto the current stack.
	 There may be room in this stackPage but there may not be room if
	 the frame were converted into a context."
	| cntxSize |
	((self headerOf: method) bitAnd: LargeContextBit) ~= 0
		ifTrue: [cntxSize := LargeContextSize / BytesPerWord - ReceiverIndex]
		ifFalse: [cntxSize := SmallContextSize / BytesPerWord - ReceiverIndex].
	^self stackPointerIndex + n <= cntxSize