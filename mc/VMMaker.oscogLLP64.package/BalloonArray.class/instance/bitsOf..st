memory access
bitsOf: value
	"Convert pos and neg ints and floats to 32-bit representations expected by C"

	value isInteger ifTrue:
		[value >= 0 ifTrue: [^ value].
		^ value + 16r80000000 + 16r80000000].
	value isFloat ifTrue:
		[^ value asIEEE32BitWord].
	self error: 'unexpected value for 32 bits'.
	^ 0