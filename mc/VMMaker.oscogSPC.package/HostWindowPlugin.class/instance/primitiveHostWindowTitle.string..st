system primitives
primitiveHostWindowTitle: id string: titleString
	"Set the title bar label of the window. Fail if the windowIndex is invalid or the platform routine returns -1 to indicate failure"
	| res titleLength |
	self primitive: 'primitiveHostWindowTitle'
		parameters: #(SmallInteger String).
	titleLength := interpreterProxy slotSizeOf: titleString cPtrAsOop.
	res := self cCode: 'ioSetTitleOfWindow(id, titleString, titleLength)'.
	res = -1
		ifTrue: [interpreterProxy primitiveFail]