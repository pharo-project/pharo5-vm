class initialization
initialize
	"self initialize"
	| wordSize bitsPerByte |
	wordSize := 4. "4 bytes per bit in the map"
	bitsPerByte := 8.
	NumPages := 256.
	PageShift := -24. "32 - (NumPages log: 2)"
	PageSize := 2 << 32 / wordSize / NumPages / bitsPerByte.
	PageMask := PageSize - 1