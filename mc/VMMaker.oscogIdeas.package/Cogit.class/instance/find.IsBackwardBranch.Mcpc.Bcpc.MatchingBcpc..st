method map
find: descriptor IsBackwardBranch: isBackwardBranchAndAnnotation Mcpc: mcpc Bcpc: bcpc MatchingBcpc: targetBcpc
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<var: #mcpc type: #'char *'>
	<var: #targetBcpc type: #'void *'>
	<inline: true>
	^targetBcpc asInteger = ((descriptor isNil or: [isBackwardBranchAndAnnotation anyMask: 1])
									ifTrue: [bcpc]
									ifFalse: [bcpc + descriptor numBytes])
		ifTrue: [mcpc asInteger]
		ifFalse: [0]