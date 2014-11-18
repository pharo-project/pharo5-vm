primitive support
ambiguousClass: aClass allInstancesInto: start limit: limit resultsInto: binaryBlock
	"Dea with ambiguity and normalize indices."
	<inline: true>
	| expectedIndex count ptr |
	count := 0.
	ptr := start.
	expectedIndex := self rawHashBitsOf: aClass.
	self allHeapEntitiesDo:
		[:obj| | actualIndex | "continue enumerating even if no room so as to unmark all objects and/or normalize class indices."
		 (MarkObjectsForEnumerationPrimitives
				ifTrue: [self isMarked: obj]
				ifFalse: [true]) ifTrue:
			[(self isNormalObject: obj)
				ifTrue:
					[MarkObjectsForEnumerationPrimitives ifTrue:
						[self setIsMarkedOf: obj to: false].
					 actualIndex := self classIndexOf: obj.
					 (self classOrNilAtIndex: actualIndex) = aClass ifTrue:
					 	[actualIndex ~= expectedIndex ifTrue:
							[self setClassIndexOf: obj to: expectedIndex].
						 count := count + 1.
						 ptr < limit ifTrue:
							[self longAt: ptr put: obj.
							 ptr := ptr + self bytesPerOop]]]
				ifFalse:
					[MarkObjectsForEnumerationPrimitives ifTrue:
						[(self isSegmentBridge: obj) ifFalse:
							[self setIsMarkedOf: obj to: false]]]]].
	self purgeDuplicateClassTableEntriesFor: aClass.
	binaryBlock value: count value: ptr
