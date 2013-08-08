system primitives
primitiveHostWindowSizeSet: windowIndex x: x y: y
	"Set the size of the user area of the window in pixels - return what is actually set by the OS/GUI/window manager. Fail if the windowIndex is invalid or the platform routine returns -1 to indicate failure"
	| size |
	self primitive: 'primitiveHostWindowSizeSet'
		parameters: #(SmallInteger SmallInteger SmallInteger).
	size := self ioSizeOfWindowSet: windowIndex x: x y: y.
	size = -1
		ifTrue: [^ interpreterProxy primitiveFail]
		ifFalse: [^ interpreterProxy makePointwithxValue: size >> 16  yValue: (size bitAnd: 16rFFFF)]