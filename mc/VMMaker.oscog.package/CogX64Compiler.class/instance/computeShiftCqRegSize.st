generate machine code
computeShiftCqRegSize
	"Immediate shifts are limited to a maximum of 31."
	<inline: true>
	| distance |
	distance := operands at: 0.
	distance = 1 ifTrue:
		[^3].
	distance <= 31 ifTrue:
		[^4].
	distance = 32 ifTrue:
		[^7].
	^8