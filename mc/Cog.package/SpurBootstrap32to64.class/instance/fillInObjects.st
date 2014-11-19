bootstrap image
fillInObjects
	"interpreter32 printOop: obj32"
	{heap32 markStack. heap32 weaklingStack. heap32 ephemeronQueue} do:
		[:obj|
		obj ~= heap32 nilObject ifTrue:
			[map at: obj put: (map at: heap32 nilObject)]].
	heap32 allObjectsDo:
		[:obj32|
		(map at: obj32 ifAbsent: nil)
			ifNotNil:
				[:obj64| | format classIndex |
				(heap64 numSlotsOf: obj64) > 0 ifTrue: "filter-out filtered objStack pages"
					[format := heap32 formatOf: obj32.
					 (heap64 isPointersFormat: format)
						ifTrue:
							[((heap64 isIndexableFormat: format)
								and: [(classIndex := heap64 classIndexOf: obj64) <= ClassBlockClosureCompactIndex
								and: [classIndex >= ClassMethodContextCompactIndex]])
								ifTrue: [self fillInPointerObjectWithPC: obj64 from: obj32]
								ifFalse: [self fillInPointerObject: obj64 from: obj32]]
						ifFalse:
							[(heap64 isCompiledMethodFormat: format)
								ifTrue: [self fillInCompiledMethod: obj64 from: obj32]
								ifFalse: [self fillInBitsObject: obj64 from: obj32]]]]
			ifNil: [self assert: (self isUnmappedObject: obj32)]]