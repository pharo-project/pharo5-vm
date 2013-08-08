method map
findMapLocationForMcpc: targetMcpc inMethod: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	| mcpc map mapByte annotation |
	mcpc := cogMethod asInteger + cmNoCheckEntryOffset.
	map := self mapStartFor: cogMethod.
	mcpc = targetMcpc ifTrue: [^map].
	[(mapByte := coInterpreter byteAt: map) ~= MapEnd] whileTrue:
		[annotation := mapByte >> AnnotationShift.
		 mcpc := mcpc + (annotation = IsDisplacementX2N
							ifTrue: [mapByte - DisplacementX2N << AnnotationShift]
							ifFalse: [mapByte bitAnd: DisplacementMask]).
		 mcpc >= targetMcpc ifTrue:
			[self assert: mcpc = targetMcpc.
			 ^map].
		 map := map - 1].
	^0