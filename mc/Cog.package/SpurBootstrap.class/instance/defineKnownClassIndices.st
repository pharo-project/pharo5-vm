class indices
defineKnownClassIndices
	"The classTable is laid out
		- to make it easy to map immediates to classes; the tag pattern of an immediate is its class index.
		  hence there are two entries for SmallInteger
		- to assign small indices to well-known classes such as Array, Message et al
		- to leave plenty of room for new known classes; hence the first page contains only well-known classes
		- to enable overlaps and avoid conflicts with indices in the specialObjectsArray (?really? eem)
		- to provide a WeakArray pun for the pages of the table itself so that these do not show up as instances of WeakArray"
	| classMethodContext classBlockClosure classMessage "no api method for these" |
	classMessage := oldHeap splObj: (VMObjectIndices bindingOf: #ClassMessage) value.
	classMethodContext := oldHeap splObj: (VMObjectIndices bindingOf: #ClassMethodContext) value.
	classBlockClosure := oldHeap splObj: (VMObjectIndices bindingOf: #ClassBlockClosure) value.
	"c.f. SpurMemoryManager class>>intializeCompactClassIndices".
	classToIndex keysDo:
		[:oldClass|
		self assert: (oldInterpreter addressCouldBeClassObj: oldClass)].
	classToIndex
		at: oldHeap classSmallInteger put: 1; "N.B. must fill-in index 3 manually"
		at: oldHeap classCharacter put: 2;
		"at: oldHeap classSmallInteger put: 3" "N.B. must fill-in index 3 manually"
		"leave room for up to 15 tagged classes"
		"leave room for up to 16 puns"
		at: oldHeap classLargeNegativeInteger put: 32;
		at: oldHeap classLargePositiveInteger put: 33;
		at: oldHeap classFloat put: 34;

		at: "oldHeap" classMessage put: 35;
		at: "oldHeap" classMethodContext put: (classMethodContextIndex := 36);
		at: "oldHeap" classBlockClosure put: (classBlockClosureIndex := 37);

		at: oldHeap classSemaphore put: 48;
		"at: oldHeap classMutex put: 49; see below"

		at: oldHeap classByteArray put: 50;
		at: oldHeap classArray put: 51;
		at: oldHeap classString put: 52;
		at: oldHeap classBitmap put: 53;
		at: oldHeap classPoint put: 54.

	{{oldHeap classMutex. 49}.
	 {oldHeap classExternalAddress. 128}.
	 {oldHeap classExternalData. 129}.
	 {oldHeap classExternalFunction. 130}.
	 {oldHeap classExternalLibrary. 131}.
	 {oldHeap classExternalStructure. 132}.
	 {oldHeap classAlien. 133}.
	 {oldHeap classUnsafeAlien. 134}}
		do: [:pair|
			[:oop :index|
			oop ~= oldHeap nilObject ifTrue:
				[classToIndex at: oop put: index]] valueWithArguments: pair].

	classToIndex keysDo:
		[:oldClass|
		self assert: (oldInterpreter addressCouldBeClassObj: oldClass)]