free space
sortFreeListAt: i
	"Sort the individual free list i so that the lowest address is at the head of the list.
	 Use an insertion sort with a scan for initially sorted elements."

	| list next head |
	list := freeLists at: i. "list of objects to be inserted"
	list = 0 ifTrue: "empty list; we're done"
		[^self].
	head := list.
	"scan list to find find first out-of-order element"
	[(next := self fetchPointer: self freeChunkNextIndex ofFreeChunk: list) > list]
		whileTrue:
			[list := next].
	"no out-of-order elements; list was already sorted; we're done"
	next = 0 ifTrue:
		[^self].
	"detatch already sorted list"
	self storePointer: self freeChunkNextIndex ofFreeChunk: list withValue: 0.
	list := next.
	[list ~= 0] whileTrue:
		[| node prev |
		 "grab next node to be inserted"
		 next := self fetchPointer: self freeChunkNextIndex ofFreeChunk: list.
		 "search sorted list for insertion point"
		 prev := 0. "prev node for insertion sort"
		 node := head. "current node for insertion sort"
		 [node ~= 0
		  and: [self oop: node isLessThan: list]] whileTrue:
			[prev := node.
			 node := self fetchPointer: self freeChunkNextIndex ofFreeChunk: node].
		 "insert the node into the sorted list"
		 self assert: (node = 0 or: [node > list]).
		 prev = 0
			ifTrue:
				[head := list]
			ifFalse:
				[self storePointer: self freeChunkNextIndex
					ofFreeChunk: prev
					withValue: list].
		 self storePointer: self freeChunkNextIndex
			ofFreeChunk: list
			withValue: node.
		list := next].
	"replace the list with the sorted list"
	freeLists at: i put: head