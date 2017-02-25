system primitives
primitiveHostWindowPositionSet: windowIndex x:  x y: y
	"Set the origin position of the user area of the window  in pixels from the topleft corner of the screen- return the position actually set by the OS/GUI/window manager. Fail if the windowIndex is invalid or the platform routine returns -1 to indicate failure"
	| pos |
	self primitive: 'primitiveHostWindowPositionSet'
		parameters: #(SmallInteger SmallInteger SmallInteger).
	pos := self ioPositionOfWindowSet: windowIndex x: x y: y.
	pos = -1
		ifTrue: [^ interpreterProxy primitiveFail]
		ifFalse: [^ interpreterProxy makePointwithxValue: pos >> 16  yValue: (pos bitAnd: 16rFFFF)]