system primitives
primitiveHostWindowSize: windowIndex 
	"Return the size of the user area of the window in pixels. Fail if the windowIndex is invalid or the platform routine returns -1 to indicate failure"
	| size |
	self primitive: 'primitiveHostWindowSize'
		parameters: #(SmallInteger ).
	size := self ioSizeOfWindow: windowIndex.
	size = -1
		ifTrue: [^ interpreterProxy primitiveFail]
		ifFalse: [^ interpreterProxy makePointwithxValue: size >> 16  yValue: (size bitAnd: 16rFFFF)]