system primitives
primitiveNativeWindowSize: windowHandle
	<option: #TerfVM>
	"Answer the size of the given native window in pixels.
	 Fail if the windowHandle is invalid or the platform routine returns -1 to indicate failure"
	| size |
	self primitive: 'primitiveNativeWindowSize'
		parameters: #(Unsigned).
	size := self ioSizeOfNativeWindow: windowHandle.
	size = -1 ifTrue:
		[^interpreterProxy primitiveFail].
	^self pointFromCompactPointEncoding: size