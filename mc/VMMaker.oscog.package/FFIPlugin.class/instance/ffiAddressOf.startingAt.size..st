primitive support
ffiAddressOf: rcvr startingAt: byteOffset size: byteSize
"return an int of the address of the byteSize slot (byte, short, int, whatever) at byteOffset in rcvr. Nominally intended for use with ExternalAddress objects, this code will work (for obscure historical reasons) with plain Byte or Word Arrays as well. "
	| rcvrClass rcvrSize addr |
	(interpreterProxy isBytes: rcvr) ifFalse:[^interpreterProxy primitiveFail].
	(byteOffset > 0) ifFalse:[^interpreterProxy primitiveFail].
	rcvrClass := interpreterProxy fetchClassOf: rcvr.
	rcvrSize := interpreterProxy byteSizeOf: rcvr.
	rcvrClass == interpreterProxy classExternalAddress ifTrue:[
		(rcvrSize = 4) ifFalse:[^interpreterProxy primitiveFail].
		addr := interpreterProxy fetchPointer: 0 ofObject: rcvr.
		"don't you dare to read from object memory!"
		(addr == 0 or:[interpreterProxy isInMemory: addr])
			ifTrue:[^interpreterProxy primitiveFail].
	] ifFalse:[
		(byteOffset+byteSize-1 <= rcvrSize)
			ifFalse:[^interpreterProxy primitiveFail].
		addr := self cCoerce: (interpreterProxy firstIndexableField: rcvr) to: 'int'.
	].
	addr := addr + byteOffset - 1.
	^addr