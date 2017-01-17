spur primitive compilation
accessorDepthForChain: chain "OrderedCollection"
	"Answer the actual number of accessors in the access chain, filtering out assignments of variables to variables."
	| accessorDepth |
	accessorDepth := 0.
	chain do:
		[:node|
		 ((node isAssignment and: [node expression isVariable])
		  or: [node isSend and: [SpurMemoryManager isSameLevelObjectAccessor: node selector]]) ifFalse:
			[accessorDepth := accessorDepth + 1]].
	^accessorDepth