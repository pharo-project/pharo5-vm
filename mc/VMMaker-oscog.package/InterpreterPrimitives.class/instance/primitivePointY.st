object access primitives
primitivePointY
	| rcvr | 
	<inline: false>
	rcvr := self popStack.
	self assertClassOf: rcvr is: (objectMemory splObj: ClassPoint).
	self successful
		ifTrue: [self push: (objectMemory fetchPointer: YIndex ofObject: rcvr)]
		ifFalse: [self unPop: 1]