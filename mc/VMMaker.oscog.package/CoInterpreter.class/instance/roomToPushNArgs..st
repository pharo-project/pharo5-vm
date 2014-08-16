primitive support
roomToPushNArgs: n
	"Answer if there is room to push n arguments onto the current stack.  We assume
	 this is called by primitives that check there is enough room in any new context, and
	 won't actually push the arguments in the current context if the primitive fails.  With
	 this assumption it is safe to answer based on the maximum argument count, /not/
	 the ammount of space in the current frame were it converted to a context.."
	false
		ifTrue: "old code that checked size of context..."
			[| methodHeader cntxSize |
			(self isMachineCodeFrame: framePointer)
				ifTrue: [methodHeader := (self mframeHomeMethod: framePointer) methodHeader]
				ifFalse: [methodHeader := objectMemory methodHeaderOf: (self iframeMethod: framePointer)].
			cntxSize := (self methodHeaderIndicatesLargeFrame: methodHeader)
							ifTrue: [LargeContextSlots - CtxtTempFrameStart]
							ifFalse: [SmallContextSlots - CtxtTempFrameStart].
			^self stackPointerIndex + n <= cntxSize]
		ifFalse: "simpler code that simply insists args are <= max arg count"
			[^n <= (LargeContextSlots - CtxtTempFrameStart)]