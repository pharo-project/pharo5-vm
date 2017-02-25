class initialization
initialize
	"DeflatePlugin initialize"
	DeflateWindowSize := 16r8000.
	DeflateWindowMask := DeflateWindowSize - 1.
	DeflateMinMatch := 3.
	DeflateMaxMatch := 258.
	DeflateMaxDistance := DeflateWindowSize.
	DeflateHashBits := 15.
	DeflateHashTableSize := 1 << DeflateHashBits.
	DeflateHashMask := DeflateHashTableSize - 1.
	DeflateHashShift := (DeflateHashBits + DeflateMinMatch - 1) // DeflateMinMatch.
	DeflateMaxLiteralCodes := ZipWriteStream maxLiteralCodes.
	DeflateMaxDistanceCodes := ZipWriteStream maxDistanceCodes.