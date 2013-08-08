method map
findMcpc: mcpc Bcpc: bcpc MatchingBcpc: targetBcpc
	<var: #mcpc type: #'char *'>
	<var: #targetBcpc type: #'void *'>
	^targetBcpc asInteger = bcpc ifTrue: [mcpc asInteger] ifFalse: [0]