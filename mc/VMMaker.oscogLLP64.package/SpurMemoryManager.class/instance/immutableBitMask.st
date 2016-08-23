header format
immutableBitMask
	"mask the immutable bit in the base header word"
	<api>
	<option: #IMMUTABILITY>
	^ 1 << self immutableBitShift