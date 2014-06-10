planning
inputsDo: aBlock
	"Evaluate the given block on my current input variable."

	direction == #forward
		ifTrue: [ aBlock value: v1 ]
		ifFalse: [ aBlock value: v2 ].