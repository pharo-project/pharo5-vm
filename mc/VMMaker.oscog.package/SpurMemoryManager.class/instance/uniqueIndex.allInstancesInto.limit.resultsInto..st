primitive support
uniqueIndex: classIndex allInstancesInto: start limit: limit resultsInto: binaryBlock
	<inline: true>
	| count ptr |
	count := 0.
	ptr := start.
	self allHeapEntitiesDo:
		[:obj| "continue enumerating even if no room so as to unmark all objects."
		 (MarkObjectsForEnumerationPrimitives
				ifTrue: [self isMarked: obj]
				ifFalse: [true]) ifTrue:
			[(self isNormalObject: obj)
				ifTrue:
					[MarkObjectsForEnumerationPrimitives ifTrue:
						[self setIsMarkedOf: obj to: false].
					 (self classIndexOf: obj) = classIndex ifTrue:
					 	[count := count + 1.
						 ptr < limit ifTrue:
							[self longAt: ptr put: obj.
							 ptr := ptr + self bytesPerOop]]]
				ifFalse:
					[MarkObjectsForEnumerationPrimitives ifTrue:
						[(self isSegmentBridge: obj) ifFalse:
							[self setIsMarkedOf: obj to: false]]]]].
	binaryBlock value: count value: ptr
