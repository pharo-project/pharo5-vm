system primitives
primitiveFile: srcName copyTo: dstName

	|srcSz dstSz ok |
	self primitive: 'primitiveFileCopyNamedTo'
		parameters: #(String String).

	srcSz := interpreterProxy slotSizeOf: srcName cPtrAsOop.
	dstSz := interpreterProxy slotSizeOf: dstName cPtrAsOop.
	ok := self sqCopyFile: srcName size: srcSz to: dstName size: dstSz.
	ok ifFalse:[interpreterProxy primitiveFail].
