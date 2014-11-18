primitive support
roomToPushNArgs: n
	"Answer if there is room to push n arguments onto the current stack.
	 There may be room in this stackPage but there may not be room if
	 the frame were converted into a context."
	| cntxSize |
	((self methodHeaderOf: method) bitAnd: LargeContextBit) ~= 0
		ifTrue: [cntxSize := LargeContextSlots - CtxtTempFrameStart]
		ifFalse: [cntxSize := SmallContextSlots - CtxtTempFrameStart].
	^self stackPointerIndex + n <= cntxSize