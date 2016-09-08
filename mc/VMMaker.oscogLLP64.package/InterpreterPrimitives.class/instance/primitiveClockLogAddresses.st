system control primitives
primitiveClockLogAddresses
	"Take a boolean which if true turns or keeps clock logging on.  Answer an array supplying
	 the size of the clock logs, the address of the usecs log, the index in it, the address of the
	 msecs log, and the index into it."
	<export: true>
	| result runInNOut usecs uidx msecs midx v1 v2 |
	<var: #usecs type: #'void *'>
	<var: #msecs type: #'void *'>
	<var: #runInNOut type: #sqInt> "bypass type inference which would deduce int"
	argumentCount ~= 1 ifTrue:
		[^self primitiveFail].
	runInNOut := (self stackValue: 0) == objectMemory trueObject.
	self ioGetClockLogSize: (self addressOf: runInNOut)
		Usecs: (self addressOf: usecs) Idx: (self addressOf: uidx)
		Msecs: (self addressOf: msecs) Idx: (self addressOf: midx).
	result := objectMemory instantiateClass: (objectMemory splObj: ClassArray) indexableSize: 5.
	result = 0 ifTrue:
		[^self primitiveFail].
	objectMemory pushRemappableOop: result.
	objectMemory storePointerUnchecked: 0 ofObject: objectMemory topRemappableOop withValue: (objectMemory integerObjectOf: runInNOut).
	v1 := self positive32BitIntegerFor: usecs asUnsignedInteger.
	v2 := self positive32BitIntegerFor: msecs asUnsignedInteger.
	self successful ifFalse:
		[objectMemory popRemappableOop.
		 ^self primitiveFail].
	objectMemory storePointer: 1 ofObject: objectMemory topRemappableOop withValue: v1.
	objectMemory storePointerUnchecked: 2 ofObject: objectMemory topRemappableOop withValue: (objectMemory integerObjectOf: uidx).
	objectMemory storePointer: 3 ofObject: objectMemory topRemappableOop withValue: v2.
	objectMemory storePointerUnchecked: 4 ofObject: objectMemory topRemappableOop withValue: (objectMemory integerObjectOf: midx).
	self pop: 2 thenPush: objectMemory popRemappableOop
