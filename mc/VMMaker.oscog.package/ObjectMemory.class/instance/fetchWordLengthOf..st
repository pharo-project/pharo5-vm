interpreter access
fetchWordLengthOf: objectPointer
	"NOTE: this gives size appropriate for fetchPointer: n, but not in general for, eg, fetchLong32, etc."

	| sz |
	sz := self sizeBitsOf: objectPointer.
	^ (sz - BaseHeaderSize) >> ShiftForWord