enumerating
nodesDo: aBlock parent: parent
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	method parseTree nodesDo: aBlock parent: self.
	aBlock value: self value: parent