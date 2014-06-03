accessing
heapMapAtWord: address Put: aBit
	"set the bit corresponding to address in the map to aBit"
	| pageIndex page bitIndex byte byteIndex |
	pageIndex := self pageIndex: address.
	page := pages at: pageIndex.
	page ifNil:
		[page := pages at: pageIndex put: (ByteArray new: PageSize)].
	byteIndex := self byteIndex: address.
	bitIndex := self bitIndex: address.
	byte := page at: byteIndex.
	byte := aBit = 0
				ifTrue: [byte - (byte bitAnd: 1 << bitIndex)]
				ifFalse: [byte bitOr: 1 << bitIndex].
	page at: byteIndex put: byte