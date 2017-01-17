*VMMaker-C translation
isAssignmentEqualsEqualsNil
	"Answer if the receiver if of the form (v := e) == nil, which underlies e ifNotNil: [:v|...]"
	^#== == (selector isSymbol ifTrue: [selector] ifFalse: [selector key])
	  and: [receiver notNil
	  and: [receiver isAssignmentNode
	  and: [(arguments first isJust: NodeNil)
		    or: [arguments first isVariableNode
			    and: [arguments first key = 'nil']]]]]