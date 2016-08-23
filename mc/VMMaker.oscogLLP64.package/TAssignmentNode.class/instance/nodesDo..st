enumerating
nodesDo: aBlock
	"Apply aBlock to all nodes in the receiver.
	 N.B. This is assumed to be bottom-up, leaves first."
	variable nodesDo: aBlock.
	expression nodesDo: aBlock.
	aBlock value: self