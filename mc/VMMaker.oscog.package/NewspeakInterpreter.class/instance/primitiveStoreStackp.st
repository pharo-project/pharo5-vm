object access primitives
primitiveStoreStackp
	"Atomic store into context stackPointer. 
	Also ensures that any newly accessible cells are initialized to nil "
	| ctxt newStackp stackp |
	ctxt := self stackValue: 1.
	newStackp := self stackIntegerValue: 0.
	self success: newStackp >= 0.
	self success: newStackp <= (LargeContextSize - BaseHeaderSize // BytesPerWord - CtxtTempFrameStart).
	self successful ifFalse: [^ self primitiveFail].
	stackp := self fetchStackPointerOf: ctxt.
	newStackp > stackp ifTrue: ["Nil any newly accessible cells"
			stackp + 1 to: newStackp do: [:i | self storePointer: i + CtxtTempFrameStart - 1 ofObject: ctxt withValue: nilObj]].
	self storeStackPointerValue: newStackp inContext: ctxt.
	self pop: 1