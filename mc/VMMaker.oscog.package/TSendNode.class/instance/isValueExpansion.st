testing
isValueExpansion
	"Answer if the receiver is of the form literalBlock value[: arg]"
	^receiver isStmtList
	 and: [selector keywords allSatisfy: [:k| #('value' 'value:') includes: k]]