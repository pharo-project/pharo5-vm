debug printing
inOrderPrintFreeTree: freeChunk printList: printNextList
	"print free chunks in freeTree in order."
	<api>
	| next |
	(next := self fetchPointer: self freeChunkSmallerIndex ofObject: freeChunk) ~= 0 ifTrue:
		[self inOrderPrintFreeTree: next printList: printNextList].
	self printFreeChunk: freeChunk isNextChunk: false.
	printNextList ifTrue:
		[next := freeChunk.
		 [(next := self fetchPointer: self freeChunkNextIndex ofObject: next) ~= 0] whileTrue:
			[coInterpreter tab.
			 self printFreeChunk: next isNextChunk: true]].
	(next := self fetchPointer: self freeChunkLargerIndex ofObject: freeChunk) ~= 0 ifTrue:
		[self inOrderPrintFreeTree: next printList: printNextList]