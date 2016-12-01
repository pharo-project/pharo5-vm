as yet unclassified
maybeCountFixup: descriptor
	"Count needed fixups; descriptor is known to be a branch or a block creation."
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<inline: true>
	numFixups := numFixups + ((descriptor isBranchTrue or: [descriptor isBranchFalse])
									ifTrue:
										[(prevBCDescriptor generator == #genSpecialSelectorEqualsEquals
										   or: [prevBCDescriptor generator == #genSpecialSelectorComparison])
											ifTrue: [3]
											ifFalse: [2]]
									ifFalse:  [1])