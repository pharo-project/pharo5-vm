system primitives
primitiveNativeDisplayPosition: windowHandle
	<option: #TerfVM>
	"Answer the origin position of the user area of the given native window in pixels from the topleft corner of the screen.
	 Fail if the windowHandle is invalid or the platform routine returns -1 to indicate failure"
	| pos |
	self primitive: 'primitiveNativeDisplayPosition'
		parameters: #(Unsigned).
	pos := self ioPositionOfNativeDisplay: windowHandle.
	pos = -1 ifTrue:
		[^interpreterProxy primitiveFail].
	^self pointFromCompactPointEncoding: pos