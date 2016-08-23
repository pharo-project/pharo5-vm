compile abstract instructions
compileEntireFullBlockMethod: numCopied
	"Compile the abstract instructions for the entire full block method."
	self allocateMergeFixups.
	^super compileEntireFullBlockMethod: numCopied