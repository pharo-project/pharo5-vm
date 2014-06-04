primitive support
sizeHeader: obj putBodySize: byteSize
	"Too lazy to set the odd bits right now.  Just insist on a multiple of 4 bytes."
	self assert: byteSize \\ 4 = 0.
	self longAt: obj - (BytesPerWord*2)
		put: ((byteSize + BytesPerWord bitAnd: LongSizeMask)
				bitOr: ((self longAt: obj - (BytesPerWord*2)) bitClear: LongSizeMask))