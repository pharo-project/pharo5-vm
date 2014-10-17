accessing
allReferencedVariables
	"Answer the set of all variables referenced in the receiver."
	| refs |
	refs := Set new.
	"find all the variable names referenced in this method"
	parseTree nodesDo:
		[:node|
		node isVariable ifTrue: [refs add: node name asString].
		node isStmtList ifTrue: [refs addAll: node args]].
	"add all the non-arg declarations (might be variables used only in cCode sections)"
	refs addAll: (declarations keys reject: [:e | self args includes: e]).
	^refs