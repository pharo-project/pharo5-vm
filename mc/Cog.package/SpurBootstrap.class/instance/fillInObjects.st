bootstrap image
fillInObjects
	oldHeap allObjectsDo:
		[:oldObj|
		(map at: oldObj ifAbsent: nil) ifNotNil:
			[:newObj| | format classIndex |
			format := newHeap formatOf: newObj.
			(newHeap isPointersFormat: format)
				ifTrue:
					[((newHeap isIndexableFormat: format)
						and: [(classIndex := newHeap classIndexOf: newObj) <= classBlockClosureIndex
						and: [classIndex >= classMethodContextIndex]])
						ifTrue: [self fillInPointerObjectWithPC: newObj from: oldObj]
						ifFalse: [self fillInPointerObject: newObj from: oldObj]]
				ifFalse:
					[(newHeap isCompiledMethodFormat: format)
						ifTrue: [self fillInCompiledMethod: newObj from: oldObj]
						ifFalse: [self fillInBitsObject: newObj from: oldObj]]]]