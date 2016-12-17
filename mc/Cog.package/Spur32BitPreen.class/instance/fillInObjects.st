bootstrap image
fillInObjects
	"interpreter32 printOop: oldObj"
	| i |
	{oldHeap markStack. oldHeap weaklingStack. oldHeap mournQueue} do:
		[:obj|
		obj ~= oldHeap nilObject ifTrue:
			[map at: obj put: (map at: oldHeap nilObject)]].
	i := 0.
	oldHeap allObjectsDo:
		[:oldObj|
		(i := i + 1) >= 10000 ifTrue:
			[Transcript nextPut: $.; flush. i := 0].
		(map at: oldObj ifAbsent: nil)
			ifNotNil:
				[:newObj| | format |
				(newHeap numSlotsOf: newObj) > 0 ifTrue: "filter-out filtered objStack pages"
					[format := oldHeap formatOf: oldObj.
					 (newHeap isPointersFormat: format)
						ifTrue:
							[self fillInPointerObject: newObj from: oldObj]
						ifFalse:
							[(newHeap isCompiledMethodFormat: format)
								ifTrue: [self fillInCompiledMethod: newObj from: oldObj]
								ifFalse: [self fillInBitsObject: newObj from: oldObj]]]]
			ifNil: [self assert: (self isUnmappedObject: oldObj)]]