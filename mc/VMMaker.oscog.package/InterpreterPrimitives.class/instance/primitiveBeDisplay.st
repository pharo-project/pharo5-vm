I/O primitives
primitiveBeDisplay
	"Record the system Display object in the specialObjectsTable,
	 and if possible pin the display bitmap.  Further, invoke ioBeDisplay
	 to alow the VM to record the location, width heigth & depth of the bitmap."
	| rcvr bitsOop depthOop heightOop widthOop |
	rcvr := self stackTop.
	((objectMemory isPointers: rcvr)
	and: [(objectMemory lengthOf: rcvr) >= 4
	and: [bitsOop := objectMemory fetchPointer: 0 ofObject: rcvr.
		((objectMemory isWordsOrBytes: bitsOop)
		or: [objectMemory isIntegerObject: bitsOop]) "for surface plugin handles"
	and: [(objectMemory isIntegerObject: (widthOop := objectMemory fetchPointer: 1 ofObject: rcvr))
	and: [(objectMemory isIntegerObject: (heightOop := objectMemory fetchPointer: 2 ofObject: rcvr))
	and: [(objectMemory isIntegerObject: (depthOop := objectMemory fetchPointer: 3 ofObject: rcvr))]]]]]) ifFalse:
		[^self primitiveFailFor: PrimErrBadReceiver].
	objectMemory splObj: TheDisplay put: rcvr.
	(objectMemory hasSpurMemoryManagerAPI
	 and: [(objectMemory isNonImmediate: bitsOop)
	 and: [(objectMemory isPinned: bitsOop) not]]) ifTrue:
		[rcvr := objectMemory pinObject: bitsOop. "Answers 0 if memory required to pin bit not enough memory available."
		 rcvr ~= 0 ifTrue: [bitsOop := rcvr]].
	self ioBeDisplay: ((objectMemory isNonImmediate: bitsOop) ifTrue: [objectMemory firstIndexableField: bitsOop] ifFalse: [bitsOop])
		width: (objectMemory integerValueOf: widthOop)
		height: (objectMemory integerValueOf: heightOop)
		depth: (objectMemory integerValueOf: depthOop)