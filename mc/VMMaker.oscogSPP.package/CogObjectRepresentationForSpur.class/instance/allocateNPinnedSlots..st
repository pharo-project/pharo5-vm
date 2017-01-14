newspeak support
allocateNPinnedSlots: nSlots
	"On Newspeak allocate the implicit receiver caches on the heap as pinned objects."
	<inline: true>
	<option: #NewspeakVM>
	| objOop |
	objOop := objectMemory allocatePinnedSlots: nSlots.
	^objOop
		ifNil: [0]
		ifNotNil: [objOop + objectMemory baseHeaderSize]