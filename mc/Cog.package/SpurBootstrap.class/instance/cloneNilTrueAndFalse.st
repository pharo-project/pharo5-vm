bootstrap image
cloneNilTrueAndFalse
	{	oldHeap nilObject.
		oldHeap falseObject.
		oldHeap trueObject. }
		with: (self firstOrdinaryClassIndex to: self firstOrdinaryClassIndex + 2)
		do: [:obj :classIndex|
			classToIndex at: (oldHeap fetchClassOfNonImm: obj) put: classIndex.
			self clone: obj classIndex: classIndex].
	newHeap
		nilObject: (map at: oldHeap nilObject); "needed for nilling objects etc"
		falseObject: (map at: oldHeap falseObject);
		trueObject: (map at: oldHeap trueObject)