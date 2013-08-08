object access primitives
primitivePointX
	| rcvr | 
	<inline: false>
	rcvr := self popStack.
	self assertClassOf: rcvr is: (self splObj: ClassPoint).
	self successful
		ifTrue: [self push: (self fetchPointer: XIndex ofObject: rcvr)]
		ifFalse: [self unPop: 1]