I/O primitives
primitiveGetWindowSize
	"Primitive. Answer the OS window's size (extent)"
	| w h |
	<export: true>
	w := self ioGetWindowWidth.
	h := self ioGetWindowHeight.
	self pop: self methodArgumentCount+1.
	self push: (self makePointwithxValue: w yValue: h).