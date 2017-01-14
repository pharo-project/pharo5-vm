quick primitives
primitivePushSelf
"	no-op, really...
	thisReceiver := self popStack.
	self push: thisReceiver
"