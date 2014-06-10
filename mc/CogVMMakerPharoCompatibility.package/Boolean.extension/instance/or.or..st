*CogVMMakerPharoCompatibility
or: block1 or: block2
	"Nonevaluating alternation without deep nesting.
	The receiver is evaluated, followed by the blocks in order.
	If any of these evaluates as true, then return true immediately,
		without evaluating any further blocks.
	If all return false, then return false."

	self
		ifTrue: [ ^ true ].
	block1 value
		ifTrue: [ ^ true ].
	block2 value
		ifTrue: [ ^ true ].
	^ false