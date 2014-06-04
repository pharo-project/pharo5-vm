C translation
generateSequentialOr: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."
	"Note: PP 2.3 compiler produces two arguments for or:, presumably
	 to help with inlining later. Taking the last agument should do the correct
	 thing even if your compiler is different."

	self emitCExpression: msgNode receiver on: aStream indent: level.
	aStream crtab: level; nextPutAll: ' || ('.
	self emitCTestBlock: msgNode args last on: aStream indent: level.
	aStream nextPutAll: ')'