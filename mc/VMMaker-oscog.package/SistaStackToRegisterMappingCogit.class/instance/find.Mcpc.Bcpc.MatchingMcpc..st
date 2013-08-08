method map
find: descriptor Mcpc: mcpc Bcpc: bcpc MatchingMcpc: targetMcpc
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<var: #mcpc type: #'char *'>
	<var: #targetMcpc type: #'void *'>
	^targetMcpc = mcpc ifTrue: [bcpc] ifFalse: [0]