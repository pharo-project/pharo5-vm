free space
unlinkSolitaryFreeTreeNode: freeTreeNode
	"Unlink a freeTreeNode.  Assumes the node has no list (null next link)."
	| parent smaller larger |
	self assert: (self fetchPointer: self freeChunkNextIndex ofFreeChunk: freeTreeNode) = 0.

	"case 1. interior node has one child, P = parent, N = node, S = subtree (mirrored for large vs small)
			___				  ___
			| P |				  | P |
		    _/_				_/_
		    | N |		=>		| S |
		 _/_
		 | S |

	 case 2: interior node has two children, , P = parent, N = node, L = smaller, left subtree, R = larger, right subtree.
	 add the left subtree to the bottom left of the right subtree (mirrored for large vs small) 
			___				  ___
			| P |				  | P |
		    _/_				_/_
		    | N |		=>		| R |
		 _/_  _\_		    _/_
		 | L | | R |		    | L |"

	smaller := self fetchPointer: self freeChunkSmallerIndex ofFreeChunk: freeTreeNode.
	larger := self fetchPointer: self freeChunkLargerIndex ofFreeChunk: freeTreeNode.
	parent := self fetchPointer: self freeChunkParentIndex ofFreeChunk: freeTreeNode.
	parent = 0
		ifTrue: "no parent; stitch the subnodes back into the root"
			[smaller = 0
				ifTrue:
					[larger ~= 0 ifTrue:
						[self storePointer: self freeChunkParentIndex ofFreeChunk: larger withValue: 0].
					 freeLists at: 0 put: larger]
				ifFalse:
					[self storePointer: self freeChunkParentIndex ofFreeChunk: smaller withValue: 0.
					 freeLists at: 0 put: smaller.
					 larger ~= 0 ifTrue:
						[self addFreeSubTree: larger]]]
		ifFalse: "parent; stitch back into appropriate side of parent."
			[smaller = 0
				ifTrue: [self storePointer: (freeTreeNode = (self fetchPointer: self freeChunkSmallerIndex ofFreeChunk: parent)
											ifTrue: [self freeChunkSmallerIndex]
											ifFalse: [self freeChunkLargerIndex])
							ofFreeChunk: parent
							withValue: larger.
						larger ~= 0 ifTrue:
							[self storePointer: self freeChunkParentIndex
								ofFreeChunk: larger
								withValue: parent]]
				ifFalse:
					[self storePointer: (freeTreeNode = (self fetchPointer: self freeChunkSmallerIndex ofFreeChunk: parent)
											ifTrue: [self freeChunkSmallerIndex]
											ifFalse: [self freeChunkLargerIndex])
						ofFreeChunk: parent
						withValue: smaller.
					 self storePointer: self freeChunkParentIndex
						ofFreeChunk: smaller
						withValue: parent.
					 larger ~= 0 ifTrue:
						[self addFreeSubTree: larger]]]