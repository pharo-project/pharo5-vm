method map
findMapLocationForMcpc: targetMcpc inMethod: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	| mcpc map mapByte annotation |
	mcpc := self firstMappedPCFor: cogMethod.
	map := self mapStartFor: cogMethod.
	mcpc = targetMcpc ifTrue: [^map].
	[(mapByte := objectMemory byteAt: map) ~= MapEnd] whileTrue:
		[annotation := mapByte >> AnnotationShift.
		 annotation ~= IsAnnotationExtension ifTrue:
			[mcpc := mcpc + (backEnd codeGranularity
								* (annotation = IsDisplacementX2N
									ifTrue: [mapByte - DisplacementX2N << AnnotationShift]
									ifFalse: [mapByte bitAnd: DisplacementMask]))].
		 mcpc >= targetMcpc ifTrue:
			[self assert: mcpc = targetMcpc.
			 annotation = IsDisplacementX2N ifTrue:
				[map := map - 1.
				 mapByte := objectMemory byteAt: map.
				 annotation := mapByte >> AnnotationShift.
				 self assert: annotation > IsAnnotationExtension].
			 ^map].
		 map := map - 1].
	^0