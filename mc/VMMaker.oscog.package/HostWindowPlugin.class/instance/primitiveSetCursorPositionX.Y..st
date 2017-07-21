system primitives
primitiveSetCursorPositionX: x Y: y
	<option: #TerfVM>
	"Set the position of the cursor to the specified position on the desktop.
	 Fail if the platform routine returns -1 to indicate failure."
	| result |
	self primitive: 'primitiveSetCursorPosition'
		parameters: #(SmallInteger SmallInteger).
	result := self ioSetCursorPositionX: x Y: y.
	result = -1 ifTrue:
		[^interpreterProxy primitiveFail]