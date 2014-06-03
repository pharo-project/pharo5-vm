callback support
sendInvokeCallback: thunkPtr Stack: stackPtr Registers: regsPtr Jmpbuf: jmpBufPtr
	"Send the 4 argument callback message invokeCallback:stack:registers:jmpbuf:
	 to Alien class with the supplied args.  The arguments are raw C addresses
	 and are converted to integer objects on the way."
	| where |
	<export: true>
	self pushRemappableOop: (self positive32BitIntegerFor: jmpBufPtr).
	self pushRemappableOop: (self positive32BitIntegerFor: regsPtr).
	self pushRemappableOop: (self positive32BitIntegerFor: stackPtr).
	self pushRemappableOop: (self positive32BitIntegerFor: thunkPtr).
	receiver := self splObj: ClassAlien.
	lkupClass := self fetchClassOfNonImm: receiver.
	messageSelector := self splObj: SelectorInvokeCallback.
	(self lookupInMethodCacheSel: messageSelector class: lkupClass) ifFalse:
	 	[(self lookupMethodNoMNUEtcInClass: lkupClass) ifFalse:
			[^false]].
	primitiveIndex ~= 0 ifTrue:
		[^false].
	self storeContextRegisters: activeContext.
	self justActivateNewMethod.
	where := activeContext + BaseHeaderSize + (ReceiverIndex << ShiftForWord).
	self longAt: where + (1 << ShiftForWord) put: self popRemappableOop.
	self longAt: where + (2 << ShiftForWord) put: self popRemappableOop.
	self longAt: where + (3 << ShiftForWord) put: self popRemappableOop.
	self longAt: where + (4 << ShiftForWord) put: self popRemappableOop.
	self interpret.
	"not reached"
	^true