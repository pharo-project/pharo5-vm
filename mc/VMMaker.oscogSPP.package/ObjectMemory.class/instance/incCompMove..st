gc -- compaction
incCompMove: bytesFreed 
	"Move all non-free objects between compStart and compEnd to their new  
	locations, restoring their headers in the process. Create a new free  
	block at the end of memory. Return the newly created free chunk. "
	"Note: The free block used by the allocator always must be the last free  
	block in memory. It may take several compaction passes to make all  
	free space bubble up to the end of memory."
	| oop next fwdBlock newOop header bytesToMove firstWord lastWord newFreeChunk sz target |
	<inline: false>
	<var: #firstWord type: 'usqInt'>
	<var: #lastWord type: 'usqInt'>
	<var: #w type: 'usqInt'>
	newOop := nil.
	oop := self oopFromChunk: compStart.
	[self oop: oop isLessThan: compEnd] whileTrue:
		[statCompMoveCount := statCompMoveCount + 1.
		next := self objectAfterWhileForwarding: oop.
		(self isFreeObject: oop) ifFalse:
			["a moving object; unwind its forwarding block"
			fwdBlock := self forwardingPointerOf: oop.
			self assert: (self fwdBlockValid: fwdBlock).
			newOop := self longAt: fwdBlock.
			header := self longAt: fwdBlock + self wordSize.
			self longAt: oop put: header. "restore the original header"
			bytesToMove := oop - newOop. "move the oop (including any extra header words) "
			sz := self sizeBitsOf: oop.
			firstWord := oop - (self extraHeaderBytes: oop).
			lastWord := oop + sz - self baseHeaderSize.
			target := firstWord - bytesToMove.
			firstWord to: lastWord by: self wordSize do:
				[:w | 
				self longAt: target put: (self longAt: w).
				target := target + self wordSize]].
		oop := next].
	newOop = nil
		ifTrue: ["no objects moved"
			oop := self oopFromChunk: compStart.
			((self isFreeObject: oop) and: [(self objectAfter: oop) = (self oopFromChunk: compEnd)])
				ifTrue: [newFreeChunk := oop]
				ifFalse: [newFreeChunk := freeBlock]]
		ifFalse: ["initialize the newly freed memory chunk"
			"newOop is the last object moved; free chunk starts 
			right after it"
			newFreeChunk := newOop + (self sizeBitsOf: newOop).
			self setSizeOfFree: newFreeChunk to: bytesFreed].
	self assert: (self objectAfter: newFreeChunk) = (self oopFromChunk: compEnd).
	(self objectAfter: newFreeChunk) = endOfMemory
		ifTrue: [self initializeMemoryFirstFree: newFreeChunk]
		ifFalse: ["newFreeChunk is not at end of memory; re-install freeBlock "
			self initializeMemoryFirstFree: freeBlock].
	^ newFreeChunk