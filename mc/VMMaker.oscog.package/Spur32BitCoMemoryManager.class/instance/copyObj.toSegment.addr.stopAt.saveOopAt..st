image segment in/out
copyObj: objOop toSegment: segmentWordArray addr: limitSeg stopAt: stopAddr saveOopAt: oopPtr
	"Copy objOop into the segment beginning at limitSeg, and forward it to the copy.
	 Fail if out of space.  Answer the next segmentAddr if successful."

	"Copy the object..."
	| bodySize copy |
	<inline: false>
	bodySize := self bytesInObject: objOop.
	(self oop: limitSeg + bodySize isGreaterThanOrEqualTo: stopAddr) ifTrue:
		[^0]. "failure"
	self mem: limitSeg cp: (self startOfObject: objOop) y: bodySize.
	copy := self objectStartingAt: limitSeg.

	"Clear remebered pinned and mark bits of all headers copied into the segment"
	self
		setIsRememberedOf: copy to: false;
		setIsPinnedOf: copy to: false;
		setIsMarkedOf: copy to: false.

	"Make sure Cogged methods have their true header field written to the segment."
	((self isCompiledMethod: objOop)
	and: [coInterpreter methodHasCogMethod: objOop]) ifTrue:
		[self storePointerUnchecked: HeaderIndex
			ofObject: copy
			withValue: (self methodHeaderOf: objOop)].

	"Remember the oop for undoing in case of prim failure."
	self longAt: oopPtr put: objOop.	
	self forward: objOop to: copy.

	"Return new end of segment"
	^limitSeg + bodySize