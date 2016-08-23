system primitives
primitiveCreateHostWindowWidth: w height: h originX: x y: y attributes: list
"Create a host window of width 'w' pixels, height 'h' with the origin of the
user area at 'x@y' from the topleft corner of the screen.
Return the SmallInt value of the internal index to the window description block
- which is whatever the host platform code needs it to be."
	| windowIndex listLength |
	self primitive: 'primitiveCreateHostWindow'
		parameters: #(SmallInteger SmallInteger SmallInteger SmallInteger ByteArray).

	"createWindowWidthheightoriginXyattr(int w, int h, int x, int y, int*
attributeList) must create a hostwindow and return an integer index. Return 0 if
failed"
	listLength := interpreterProxy slotSizeOf: list cPtrAsOop.
	windowIndex := self createWindowWidth: w height: h originX: x y: y attr: list
length: listLength.
	windowIndex > 0 ifTrue:[^windowIndex asSmallIntegerObj]
		ifFalse:[^interpreterProxy primitiveFail].
