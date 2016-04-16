compile abstract instructions
compileEntireMethod
	"Compile the abstract instructions for the entire method, including blocks."
	self allocateMergeFixups.
	^super compileEntireMethod