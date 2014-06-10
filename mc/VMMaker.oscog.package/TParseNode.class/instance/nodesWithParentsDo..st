enumerating
nodesWithParentsDo: aBlock
	"Apply aBlock to all nodes in the receiver with each node's parent.
	 N.B. This is assumed to be bottom-up, leaves first."
	self nodesDo: aBlock parent: nil