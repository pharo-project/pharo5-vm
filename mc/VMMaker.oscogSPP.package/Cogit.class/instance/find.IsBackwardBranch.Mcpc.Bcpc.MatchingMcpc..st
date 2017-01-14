method map
find: descriptor IsBackwardBranch: isBackwardBranchAndAnnotation Mcpc: mcpc Bcpc: bcpc MatchingMcpc: targetMcpc
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<var: #mcpc type: #'char *'>
	<var: #targetMcpc type: #'void *'>
	"Machine code addresses map to the following bytecode for all bytecodes
	 except backward branches, where they map to the backward branch itself.
	 This is so that loops continue, rather than terminate prematurely."
	^targetMcpc = mcpc
		ifTrue: [(descriptor isNil or: [isBackwardBranchAndAnnotation anyMask: 1])
					ifTrue: [bcpc]
					ifFalse: [bcpc + descriptor numBytes]]
		ifFalse: [0]