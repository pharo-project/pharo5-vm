method map
printPCMapPairsFor: cogMethod on: aStream
	<doNotGenerate>
	<inline: true>
	| mcpc map mapByte annotation |
	mcpc := self firstMappedPCFor: cogMethod.
	map := self mapStartFor: cogMethod.
	[(mapByte := objectMemory byteAt: map) ~= MapEnd] whileTrue:
		[annotation := mapByte >> AnnotationShift.
		 annotation ~= IsAnnotationExtension ifTrue:
			[mcpc := mcpc + (backEnd codeGranularity
								* (annotation = IsDisplacementX2N
									ifTrue: [mapByte - DisplacementX2N << AnnotationShift]
									ifFalse: [mapByte bitAnd: DisplacementMask]))].
		 aStream ensureCr.
		 map printOn: aStream base: 16.
		 aStream nextPutAll: ': '.
		 mapByte printOn: aStream base: 16 length: 2 padded: true.
		 aStream space.
		 annotation printOn: aStream base: 16.
		 aStream nextPutAll: ' ('; print: (AnnotationConstantNames at: annotation + 1); nextPutAll: ') '.
		 (mapByte bitAnd: DisplacementMask) printOn: aStream base: 16.
		 aStream space.
		 aStream nextPut: $@.
		 mcpc printOn: aStream base: 16.
		 aStream flush.
		 map := map - 1]