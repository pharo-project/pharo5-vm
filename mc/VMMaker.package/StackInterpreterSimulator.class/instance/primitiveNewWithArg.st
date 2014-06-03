debugging traps
primitiveNewWithArg
	"(objectMemory hasSpurMemoryManagerAPI
	 and: [self classNameOf: (self stackValue: 1) Is: 'MethodDictionary']) ifTrue:
		[self halt]."
	"| hash |
	hash := objectMemory rawHashBitsOf: (self stackValue: 1)."
	"| format |
	format := objectMemory instSpecOfClass: (self stackValue: 1)."
	"(objectMemory numSlotsOf: (self stackValue: 1)) = 3 ifTrue:
		[self halt]."
	super primitiveNewWithArg.
	"self successful ifTrue:
		[(Smalltalk at: #Counts ifAbsentPut: [Bag new]) add: format]."
	"(self successful and: [objectMemory hasSpurMemoryManagerAPI]) ifTrue:
		[(Smalltalk at: #Counts ifAbsentPut: [Bag new]) add: hash]"
	"Smalltalk removeKey: #Counts"
	"Counts sortedCounts collect: [:assoc|
		assoc key -> ((SpurMemoryManager organization listAtCategoryNamed: #'header formats') detect:
										[:f| (SpurMemoryManager basicNew perform: f) = assoc value])]
		{3251->#arrayFormat.
		 1685->#firstByteFormat.
		 1533->#firstLongFormat.
		 110->#weakArrayFormat.
		 35->#indexablePointersFormat.
		 5->#nonIndexablePointerFormat}"
	"Counts sortedCounts collect: [:assoc|
		assoc value = 0
			ifTrue: [assoc]
			ifFalse: [assoc key -> {(self nameOfClass: (objectMemory classAtIndex: assoc value)).
									(SpurMemoryManager organization listAtCategoryNamed: #'header formats') detect:
										[:f| (objectMemory perform: f)
											= (objectMemory instSpecOfClass: (objectMemory classAtIndex: assoc value))]}]]
	{1062->#('Array' #arrayFormat).
	 777->#('Bitmap' #firstLongFormat).
	 395->#('Float' #firstLongFormat).
	 345->#('ByteString' #firstByteFormat).
	 237->#('MatrixTransform2x3' #firstLongFormat).
	 233->#('LargePositiveInteger' #firstByteFormat).
	 103->#('WordArray' #firstLongFormat).
	 58->#('WeakArray' #weakArrayFormat).
	 52->#('WeakMessageSend' #weakArrayFormat).
	 9->#('MethodContext' #indexablePointersFormat).
	 4->#('DirectoryEntry' #nonIndexablePointerFormat).
	 3->#('BalloonBuffer' #firstLongFormat).
	 1->#('ByteArray' #firstByteFormat).
	 1->0}"