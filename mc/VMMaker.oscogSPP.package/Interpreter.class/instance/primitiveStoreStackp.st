object access primitives
primitiveStoreStackp
	"Atomic store into context stackPointer. 
	Also ensures that any newly accessible cells are initialized to nil "
	| ctxt newStackp stackp |
	ctxt := self stackValue: 1.
	newStackp := self stackIntegerValue: 0.
	self success: newStackp >= 0.
	self success: newStackp <= (LargeContextSlots - CtxtTempFrameStart).
	successFlag ifFalse: [^ self primitiveFail].
	stackp := self fetchStackPointerOf: ctxt.
	"Nil any newly accessible cells"
	stackp + 1 to: newStackp do:
		[:i | self storePointerUnchecked: i + CtxtTempFrameStart - 1 ofObject: ctxt withValue: nilObj].
	self storeStackPointerValue: newStackp inContext: ctxt.
	self pop: 1