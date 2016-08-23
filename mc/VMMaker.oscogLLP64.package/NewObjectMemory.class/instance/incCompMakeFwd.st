gc -- compaction
incCompMakeFwd
	"Create and initialize forwarding blocks for all non-free objects  
	 following compStart. If the supply of forwarding blocks is exhausted,  
	 set compEnd to the first chunk above the area to be compacted;
	 otherwise, set it to endOfMemory. Return the number of bytes to be freed."
	| bytesToBeFreed oop fwdBlock newOop |
	<inline: false>
	bytesToBeFreed := 0.
	oop := self oopFromChunk: compStart.
	self assert: (self oop: oop isGreaterThan: self startOfMemory andLessThan: freeStart).
	[self oop: oop isLessThan: freeStart] whileTrue:
		[statMkFwdCount := statMkFwdCount + 1.
		 self assert: (self oop: oop isGreaterThan: self startOfMemory andLessThan: freeStart).
		 (self isFreeObject: oop)
			ifTrue: [bytesToBeFreed := bytesToBeFreed + (self sizeOfFree: oop)]
			ifFalse: "create a forwarding block for oop"
				[fwdBlock := self fwdBlockGet: self wordSize*2.
				 "Two-word block"
				 fwdBlock = nil ifTrue: "stop; we have used all available forwarding blocks"
					[compEnd := self chunkFromOop: oop.
					 ^bytesToBeFreed].
				newOop := oop - bytesToBeFreed.
				self assert: (self oop: newOop isGreaterThan: self startOfMemory andLessThan: freeStart).
				self initForwardBlock: fwdBlock mapping: oop to: newOop withBackPtr: false].
			oop := self objectAfterWhileForwarding: oop].
	compEnd := freeStart.
	^bytesToBeFreed