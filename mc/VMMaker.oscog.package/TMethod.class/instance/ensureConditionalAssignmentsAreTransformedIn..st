inlining
ensureConditionalAssignmentsAreTransformedIn: aCodeGen
	"Make passes transforming
		foo := expr ifTrue: [a] ifFalse: [b]
	 into
		expr ifTrue: [foo := a] ifFalse: [foo := b]
	 until no such instances exist in the tree.  This is needed for correct inlining
	 given the limitations of inlineCodeOrNilForStatement:returningNodes:in:"
	| transformedAssignments |
	[transformedAssignments := Dictionary new.
	 parseTree
		nodesDo:
			[:node|
			(self transformConditionalAssignment: node in: aCodeGen) ifNotNil:
				[:replacement|
				 transformedAssignments at: node put: replacement]]
		unless: "Don't inline the arguments to asserts to keep the asserts readable"
			[:node|
			node isSend
			and: [node selector == #cCode:inSmalltalk:
				or: [aCodeGen isAssertSelector: node selector]]].
	 transformedAssignments notEmpty
	 and: [self replaceNodesIn: transformedAssignments.
		  true]] whileTrue
		