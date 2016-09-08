gc -- compaction
incCompMakeFwd
	"Create and initialize forwarding blocks for all non-free objects  
	following compStart. If the supply of forwarding blocks is exhausted,  
	set compEnd to the first chunk above the area to be 
	compacted; otherwise, set it to endOfMemory. Return the number of 
	bytes to be freed."
	| bytesFreed oop fwdBlock newOop |
	<inline: false>
	bytesFreed := 0.
	oop := self oopFromChunk: compStart.
	[self oop: oop isLessThan: endOfMemory]
		whileTrue: [
				statMkFwdCount := statMkFwdCount + 1.
				(self isFreeObject: oop)
				ifTrue: [bytesFreed := bytesFreed + (self sizeOfFree: oop)]
				ifFalse: ["create a forwarding block for oop"
					fwdBlock := self fwdBlockGet: self wordSize*2.
					"Two-word block"
					fwdBlock = nil
						ifTrue: ["stop; we have used all available forwarding blocks"
							compEnd := self chunkFromOop: oop.
							^ bytesFreed].
					newOop := oop - bytesFreed.
					self initForwardBlock: fwdBlock mapping: oop to: newOop withBackPtr: false].
			oop := self objectAfterWhileForwarding: oop].
	compEnd := endOfMemory.
	^ bytesFreed