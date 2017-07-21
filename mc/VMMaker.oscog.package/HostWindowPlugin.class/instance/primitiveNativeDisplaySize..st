system primitives
primitiveNativeDisplaySize: windowHandle
	<option: #TerfVM>
	"Answer the size of the user area of the given native window in pixels.
	 Fail if the windowHandle is invalid or the platform routine returns -1 to indicate failure"
	| size |
	self primitive: 'primitiveNativeDisplaySize'
		parameters: #(Unsigned).
	size := self ioSizeOfNativeDisplay: windowHandle.
	size = -1 ifTrue:
		[^interpreterProxy primitiveFail].
	^self pointFromCompactPointEncoding: size