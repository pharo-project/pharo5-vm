method map
findMcpc: mcpc Bcpc: bcpc MatchingMcpc: targetMcpc
	<var: #mcpc type: #'char *'>
	<var: #targetMcpc type: #'void *'>
	^targetMcpc = mcpc ifTrue: [bcpc] ifFalse: [0]