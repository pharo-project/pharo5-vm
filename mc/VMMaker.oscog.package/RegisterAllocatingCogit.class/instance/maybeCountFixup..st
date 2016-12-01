as yet unclassified
maybeCountFixup: descriptor
	"Count needed fixups; descriptor is known to be a branch or a block creation."
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<inline: true>
	numFixups := numFixups + (descriptor isBranch
									ifTrue:
										[((descriptor isBranchTrue or: [descriptor isBranchFalse])
										  and: [prevBCDescriptor generator == #genSpecialSelectorEqualsEquals
												or: [prevBCDescriptor generator == #genSpecialSelectorComparison]])
													ifTrue: [3]
													ifFalse: [2]] "Forward branches only need one, but backward branches need two"
									ifFalse:  [1]) "blocks"