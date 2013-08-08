I/O primitives
primitiveGetNextEvent
	"Primitive. Return the next input event from the VM event queue."
	| evtBuf arg value |
	<var: #evtBuf declareC:'int evtBuf[8] = { 0, 0, 0, 0, 0, 0, 0, 0 }'>
	self cCode:'' inSmalltalk:[evtBuf := CArrayAccessor on: (IntegerArray new: 8)].
	arg := self stackTop.
	((self isArray: arg) and:[(self slotSizeOf: arg) = 8])  ifFalse:[^self primitiveFail].

	self ioGetNextEvent: (self cCoerce: evtBuf to: 'sqInputEvent*').
	self successful ifFalse:[^nil].

	"Event type"
	self storeInteger: 0 ofObject: arg withValue: (evtBuf at: 0).
	self successful ifFalse:[^nil].

	"Event time stamp"
	self storeInteger: 1 ofObject: arg withValue: ((evtBuf at: 1) bitAnd: MillisecondClockMask).
	self successful ifFalse:[^nil].

	"Event arguments"
	2 to: 7 do:[:i|
		value := evtBuf at: i.
		(self isIntegerValue: value)
			ifTrue:[self storeInteger: i ofObject: arg withValue: value]
			ifFalse:["Need to remap because allocation may cause GC"
				self pushRemappableOop: arg.
				value := self positive32BitIntegerFor: value.
				arg := self popRemappableOop.
				self storePointer: i ofObject: arg withValue: value]].

	self successful ifFalse:[^nil].
	self pop: 1.