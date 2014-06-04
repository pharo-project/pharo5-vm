stack bytecodes
pushClosureCopyCopiedValuesBytecode
	"The compiler has pushed the values to be copied, if any.  Find numArgs and numCopied in the byte following.
	 Create a Closure with space for the copiedValues and pop numCopied values off the stack into the closure.
	 Set numArgs as specified, and set startpc to the pc following the block size and jump over that code."
	| numArgsNumCopied numArgs numCopied blockSize |
	numArgsNumCopied := self fetchByte.
	numArgs := numArgsNumCopied bitAnd: 16rF.
	numCopied := numArgsNumCopied bitShift: -4.
	"Split blockSize := (self fetchByte * 256) + self fetchByte. into two because evaluation order in C is undefined."
	blockSize := self fetchByte << 8.
	blockSize := blockSize + self fetchByte.
	self pushClosureNumArgs: numArgs copiedValues: numCopied blockSize: blockSize