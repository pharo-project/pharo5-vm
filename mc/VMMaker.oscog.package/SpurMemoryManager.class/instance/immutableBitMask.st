header format
immutableBitMask
	"mask the immutable bit in the base header word"
	<option: #IMMUTABILITY>
	^ 1 << self immutableBitShift