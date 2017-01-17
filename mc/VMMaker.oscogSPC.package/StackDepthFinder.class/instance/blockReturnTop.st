instruction decoding
blockReturnTop
	"Return Top Of Stack bytecode."
	self drop.
	self resetStackAfterBranchOrReturn