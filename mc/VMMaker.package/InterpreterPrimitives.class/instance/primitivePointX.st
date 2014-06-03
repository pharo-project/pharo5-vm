object access primitives
primitivePointX
	| rcvr | 
	<inline: false>
	rcvr := self popStack.
	self assertClassOf: rcvr is: (objectMemory splObj: ClassPoint).
	self successful
		ifTrue: [self push: (objectMemory fetchPointer: XIndex ofObject: rcvr)]
		ifFalse: [self unPop: 1]