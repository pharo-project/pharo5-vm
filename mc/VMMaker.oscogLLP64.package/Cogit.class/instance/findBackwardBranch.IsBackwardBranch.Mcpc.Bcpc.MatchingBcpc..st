method map
findBackwardBranch: descriptor IsBackwardBranch: isBackwardBranchAndAnnotation Mcpc: mcpc Bcpc: bcpc MatchingBcpc: targetBcpc
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<var: #mcpc type: #'char *'>
	<var: #targetBcpc type: #'void *'>
	<inline: true>
	^((isBackwardBranchAndAnnotation anyMask: 1) and: [targetBcpc asInteger = bcpc])
		ifTrue: [mcpc asInteger]
		ifFalse: [0]