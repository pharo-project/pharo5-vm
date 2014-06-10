method map
findBackwardBranch: descriptor IsBackwardBranch: isBackwardBranch Mcpc: mcpc Bcpc: bcpc MatchingBcpc: targetBcpc
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<var: #mcpc type: #'char *'>
	<var: #targetBcpc type: #'void *'>
	<inline: true>
	^(isBackwardBranch and: [targetBcpc asInteger = bcpc])
		ifTrue: [mcpc asInteger]
		ifFalse: [0]