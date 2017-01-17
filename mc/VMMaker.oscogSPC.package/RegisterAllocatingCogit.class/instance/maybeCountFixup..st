compile abstract instructions
maybeCountFixup: descriptor
	"Count needed fixups; descriptor is known to be a branch or a block creation."
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<inline: true>
	numFixups := numFixups + ((descriptor isBranchTrue or: [descriptor isBranchFalse])
									ifTrue: [2]
									ifFalse: [1])