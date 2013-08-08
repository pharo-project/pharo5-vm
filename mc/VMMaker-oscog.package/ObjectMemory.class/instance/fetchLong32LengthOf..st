interpreter access
fetchLong32LengthOf: objectPointer
	"Gives size appropriate for, eg, fetchLong32"

	| sz |
	sz := self sizeBitsOf: objectPointer.
	^ (sz - BaseHeaderSize) >> 2