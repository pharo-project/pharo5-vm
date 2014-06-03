utilities
addressOf: rcvr startingAt: byteOffset size: byteSize
"Return the int of the address of the (byteSize) slot at btyeOffset in rcvr. Usde for getting byte/word/int/float/double out of Byte/WordArrays"
	| rcvrSize addr |
	(self isBytes: rcvr) ifFalse:
		[^self primitiveFailFor: PrimErrInappropriate].
	(byteOffset > 0) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	rcvrSize := self byteSizeOf: rcvr.
	(byteOffset+byteSize-1 <= rcvrSize) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	addr := self oopForPointer: (self firstIndexableField: rcvr).
	addr := addr + byteOffset - 1.
	^addr