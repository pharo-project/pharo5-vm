enumerating
nodesDo: aBlock
	"Apply aBlock to all nodes in the receiver.
	 N.B. This is assumed to be bottom-up, leaves first."
	expression nodesDo: aBlock.
	cases do:
		[:pair|
		pair first do: [:node| node nodesDo: aBlock].
		pair last nodesDo: aBlock].
	otherwiseOrNil ifNotNil:
		[otherwiseOrNil nodesDo: aBlock].
	aBlock value: self