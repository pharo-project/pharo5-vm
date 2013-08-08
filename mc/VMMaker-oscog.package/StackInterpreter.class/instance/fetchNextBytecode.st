interpreter shell
fetchNextBytecode
	"This method fetches the next instruction (bytecode). Each bytecode method is responsible for fetching the next bytecode, preferably as early as possible to allow the memory system time to process the request before the next dispatch."

	self cppIf: MULTIPLEBYTECODESETS
		ifTrue: [currentBytecode := self fetchByte + bytecodeSetSelector]
		ifFalse: [currentBytecode := self fetchByte]