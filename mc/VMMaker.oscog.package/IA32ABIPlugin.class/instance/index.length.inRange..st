private-support
index: byteIndex length: length inRange: rcvr
	"Answer if the indices byteIndex to byteIndex + length - 1 are valid zero-relative indices into the rcvr.
	 Beware!  There be dragons here.  The form below (byteIndex <= (dataSize abs - length)) is used
	 because byteIndex + length could overflow, whereas (dataSize abs - length) can't.  We *don't* use the
	 obvious optimization
		^dataSize = 0 or: [byteIndex asUnsignedInteger <= (dataSize abs - length)]
	 because with C's Usual Arithmetic Conversions
		5. Otherwise, both operands are converted to the unsigned integer type corresponding to the type of the operand with signed integer type.
	 means that the comparison will be unsigned, and if length > dataSize abs then dataSize abs - length is large and positive."
	| dataSize |
	<inline: true>
	dataSize := self sizeField: rcvr.
	^dataSize = 0 or: [byteIndex >= 0 and: [byteIndex <= (dataSize abs - length)]]