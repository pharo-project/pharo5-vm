testing
testDefaultImageFormats
	"Original 32-bit image format, and the original 64-bit image format, prior to
	introduction of block closure support."

	self assert: (6502 = (ImageFormat wordSize: 4) asInteger).
	self assert: (68000 = (ImageFormat wordSize: 8) asInteger).
	self should: [ImageFormat wordSize: 0] raise: Error.
	self should: [ImageFormat wordSize: 12] raise: Error