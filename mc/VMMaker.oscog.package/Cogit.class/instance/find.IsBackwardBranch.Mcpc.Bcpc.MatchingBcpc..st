method map
find: descriptor IsBackwardBranch: isBackwardBranch Mcpc: mcpc Bcpc: bcpc MatchingBcpc: targetBcpc
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<var: #mcpc type: #'char *'>
	<var: #targetBcpc type: #'void *'>
	<inline: true>
	^targetBcpc asInteger = ((descriptor isNil or: [isBackwardBranch]) ifTrue: [bcpc] ifFalse: [bcpc + descriptor numBytes])
		ifTrue: [mcpc asInteger]
		ifFalse: [0]