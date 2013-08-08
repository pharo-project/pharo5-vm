system primitives
primitiveShowHostWindow: windowIndex bits: dispBits width: w height: h depth: d
left: left right: right top: top bottom: bottom
"Host window analogue of DisplayScreen> primShowRectLeft:right:top:bottom:
(Interpreter>primitiveShowDisplayRect) which takes the window index, bitmap
details and the rectangle bounds. Fail if the windowIndex is invalid or the
platform routine returns false to indicate failure"
	|ok|
	self primitive: 'primitiveShowHostWindowRect'
		parameters: #(SmallInteger WordArray SmallInteger SmallInteger SmallInteger
SmallInteger SmallInteger SmallInteger SmallInteger).

	"Tell the vm to copy pixel's from dispBits to the screen - this is just
ioShowDisplay with the extra parameter of the windowIndex integer"
	ok := self cCode: 'ioShowDisplayOnWindow(dispBits, w, h, d, left, right, top,
bottom, windowIndex)'.
	ok ifFalse:[interpreterProxy primitiveFail]