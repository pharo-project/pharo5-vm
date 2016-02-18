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
	where := activeContext + self baseHeaderSize + (ReceiverIndex << self shiftForWord).
	self longAt: where + (1 << self shiftForWord) put: self popRemappableOop.
	self longAt: where + (2 << self shiftForWord) put: self popRemappableOop.
	self longAt: where + (3 << self shiftForWord) put: self popRemappableOop.
	self longAt: where + (4 << self shiftForWord) put: self popRemappableOop.
	self interpret.
	"not reached"
	^true