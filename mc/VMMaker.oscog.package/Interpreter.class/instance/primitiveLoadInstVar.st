quick primitives
primitiveLoadInstVar
	| thisReceiver |
	thisReceiver := self popStack.
	self push: (self fetchPointer: primitiveIndex-264 ofObject: thisReceiver)