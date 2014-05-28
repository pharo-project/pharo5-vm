*CogVMMakerPharoCompatibility
and: block1 and: block2
	"Nonevaluating conjunction without deep nesting.
	The receiver is evaluated, followed by the blocks in order.
	If any of these evaluates as false, then return false immediately,
		without evaluating any further blocks.
	If all return true, then return true."

	self
		ifFalse: [ ^ false ].
	block1 value
		ifFalse: [ ^ false ].
	block2 value
		ifFalse: [ ^ false ].
	^ true