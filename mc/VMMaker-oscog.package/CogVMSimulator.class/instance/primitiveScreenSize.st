I/O primitives
primitiveScreenSize
	| size |
	size := self desiredDisplayExtent min: 800@640.
	self pop: 1 thenPush: (self makePointwithxValue: size x yValue: size y)