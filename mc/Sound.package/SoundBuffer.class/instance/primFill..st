primitives
primFill: aPositiveInteger
	"Fill the receiver, an indexable bytes or words object, with the given positive integer. The range of possible fill values is [0..255] for byte arrays and [0..(2^32 - 1)] for word arrays."
	"Note: Since 16-bit word arrays are not built into the virtual machine, this primitive fills by 32-bit words."

	<primitive: 145>
	self errorImproperStore.
