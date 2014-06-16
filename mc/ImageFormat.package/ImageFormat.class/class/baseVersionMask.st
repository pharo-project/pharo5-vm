image formats
baseVersionMask
	"Mask the bits associated with base format number exclusive of capability bits"

	"ImageFormat baseVersionMask printStringBase: 2"

	^ BaseVersionNumbers
		inject: 0
		into: [:accum :e | accum bitOr: e]
