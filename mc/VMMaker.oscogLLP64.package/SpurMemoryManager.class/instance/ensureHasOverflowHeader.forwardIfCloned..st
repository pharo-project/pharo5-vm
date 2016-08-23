image segment in/out
ensureHasOverflowHeader: arrayArg forwardIfCloned: forwardIfCloned
	"If arrayArg is too short to be truncated, clone it so that the clone is long enough.
	 Answer nil if it can't be cloned."
	<inline: false>
	(self hasOverflowHeader: arrayArg) ifTrue:
		[^arrayArg].
	^(self
		allocateSlots: self numSlotsMask + 1
		format: (self formatOf: arrayArg)
		classIndex: (self classIndexOf: arrayArg)) ifNotNil:
			[:clonedArray|
			 self mem: clonedArray + self baseHeaderSize
				 cp: arrayArg + self baseHeaderSize
				 y: (self numSlotsOf: arrayArg) * self bytesPerOop.
			 (self isRemembered: arrayArg) ifTrue:
				[scavenger remember:  clonedArray].
			 forwardIfCloned ifTrue:
				[self forward: arrayArg to: clonedArray].
			 clonedArray]