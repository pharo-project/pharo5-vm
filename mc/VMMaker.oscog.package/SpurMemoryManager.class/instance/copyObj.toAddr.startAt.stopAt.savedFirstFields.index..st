image segment in/out
copyObj: objOop toAddr: segAddr startAt: segStart stopAt: endSeg savedFirstFields: savedFirstFields index: i
	"This is part of storeImageSegmentInto:outPointers:roots:.
	 Copy objOop into the segment beginning at segAddr, and forward it to the copy,
	 saving its first field in savedFirstField, and setting its marked bit to indicate it has
	 been copied.  If it is a class in the class table, set the copy's hash to 0 for reassignment
	 on load, and mark it as a class by setting its isRemembered bit.
	 Answer the next segmentAddr if successful.  Answer an appropriate error code if not"

	"Copy the object..."
	| bodySize copy hash |
	<inline: false>
	bodySize := self bytesInObject: objOop.
	(self oop: segAddr + bodySize isGreaterThanOrEqualTo: endSeg) ifTrue:
		[^PrimErrWritePastObject halt].
	self mem: segAddr asVoidPointer cp: (self startOfObject: objOop) asVoidPointer y: bodySize.
	copy := self objectStartingAt: segAddr.

	"Clear remembered, mark bits of all headers copied into the segment (except classes)"
	self
		setIsRememberedOf: copy to: false;
		setIsMarkedOf: copy to: false.

	"Make any objects with hidden dynamic state (contexts, methods) look like normal objects."
	self ifAProxy: objOop updateCopy: copy.

	"If the object is a class, zero its identityHash (which is its classIndex) and set its
	 isRemembered bit.  It will be assigned a new hash and entered into the table on load."
	hash := self rawHashBitsOf: objOop.
	(hash > self lastClassIndexPun and: [(self classOrNilAtIndex: hash) = objOop]) ifTrue:
		[self setHashBitsOf: copy to: 0.
		 self setIsRememberedOf: copy to: true].

	"Now forward the object to its copy in the segment."
	self storePointerUnchecked: i ofObject: savedFirstFields withValue: (self fetchPointer: 0 ofObject: objOop);
		storePointerUnchecked: 0 ofObject: objOop withValue: copy;
		setIsMarkedOf: objOop to: true.

	"Answer the new end of segment"
	^segAddr + bodySize