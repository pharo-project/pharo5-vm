system primitives
primitiveHostWindowPosition: windowIndex 
	"Return the origin position of the user area of the window in pixels from the topleft corner of the screen. Fail if the windowIndex is invalid or the platform routine returns -1 to indicate failure"
	| pos |
	self primitive: 'primitiveHostWindowPosition'
		parameters: #(SmallInteger ).
	pos := self ioPositionOfWindow: windowIndex.
	pos = -1
		ifTrue: [^ interpreterProxy primitiveFail]
		ifFalse: [^ interpreterProxy makePointwithxValue: pos >> 16  yValue: (pos bitAnd: 16rFFFF)]