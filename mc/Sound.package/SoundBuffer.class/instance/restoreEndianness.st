objects from disk
restoreEndianness
	"This word object was just read in from a stream.  It was stored in Big Endian (Mac) format.  Swap each pair of bytes (16-bit word), if the current machine is Little Endian.
	Why is this the right thing to do?  We are using memory as a byteStream.  High and low bytes are reversed in each 16-bit word, but the stream of words ascends through memory.  Different from a Bitmap."

	| hack blt |
	SmalltalkImage current  isLittleEndian ifTrue: [
		"The implementation is a hack, but fast for large ranges"
		hack := Form new hackBits: self.
		blt := (BitBlt toForm: hack) sourceForm: hack.
		blt combinationRule: Form reverse.  "XOR"
		blt sourceY: 0; destY: 0; height: self size; width: 1.
		blt sourceX: 0; destX: 1; copyBits.  "Exchange bytes 0 and 1"
		blt sourceX: 1; destX: 0; copyBits.
		blt sourceX: 0; destX: 1; copyBits.
		blt sourceX: 2; destX: 3; copyBits.  "Exchange bytes 2 and 3"
		blt sourceX: 3; destX: 2; copyBits.
		blt sourceX: 2; destX: 3; copyBits].

