compile abstract instructions
getLiteral: litIndex
	maxLitIndex < litIndex ifTrue:
		[maxLitIndex := litIndex].
	^coInterpreter literal: litIndex ofMethod: methodObj