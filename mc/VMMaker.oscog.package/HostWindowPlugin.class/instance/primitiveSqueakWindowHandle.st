system primitives
primitiveSqueakWindowHandle
	<option: #TerfVM>
	"Answer the native Squeak window handle, presumably a pointer, as an unsigned integer.
	 This value should be usable in native calls to the window manager as well as
	 the argument to primitiveNativeWindowPosition:"
	| handle |
	<var: #handle type: 'void *'>
	self primitive: 'primitiveSqueakWindowHandle'.
	handle := self ioGetWindowHandle.
	handle = 0 ifTrue:
		[^interpreterProxy primitiveFail].
	^interpreterProxy positiveMachineIntegerFor: (self cCoerceSimple: handle to: #sqInt)