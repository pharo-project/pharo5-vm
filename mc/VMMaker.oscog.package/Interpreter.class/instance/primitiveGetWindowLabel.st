I/O primitives
primitiveGetWindowLabel
	"Primitive. Answer the OS window's label"
	| ptr sz labelOop |
	<var: 'ptr' type: 'char*'>
	<export: true>
	ptr := self ioGetWindowLabel.
	ptr == nil ifTrue:[^self success: false].
	sz := self strlen: ptr.
	labelOop := self instantiateClass: self classString indexableSize: sz.
	0 to: sz-1 do:[:i| self storeByte: i ofObject: labelOop withValue: (ptr at: i)].
	self pop: self methodArgumentCount+1.
	self push: labelOop.