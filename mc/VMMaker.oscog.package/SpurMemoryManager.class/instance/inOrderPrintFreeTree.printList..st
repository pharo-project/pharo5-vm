debug printing
inOrderPrintFreeTree: freeChunk printList: printNextList
	"print free chunks in freeTree in order."
	<api>
	| next |
	(next := self fetchPointer: self freeChunkSmallerIndex ofFreeChunk: freeChunk) ~= 0 ifTrue:
		[self inOrderPrintFreeTree: next printList: printNextList].
	self printFreeChunk: freeChunk printAsTreeNode: true.
	printNextList ifTrue:
		[next := freeChunk.
		 [(next := self fetchPointer: self freeChunkNextIndex ofFreeChunk: next) ~= 0] whileTrue:
			[coInterpreter tab.
			 self printFreeChunk: next printAsTreeNode: false]].
	(next := self fetchPointer: self freeChunkLargerIndex ofFreeChunk: freeChunk) ~= 0 ifTrue:
		[self inOrderPrintFreeTree: next printList: printNextList]