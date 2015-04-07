method map
annotationForMcpc: mcpc in: cogHomeMethod
	"Answer the annotation for mcpc in cogHomeMethod's map, or 0 if no entry exists."
	<var: #cogHomeMethod type: #'CogMethod *'>
	| mapLocation mapByte annotation |
	mapLocation := self findMapLocationForMcpc: mcpc inMethod: cogHomeMethod.
	mapLocation = 0 ifTrue:
		[^0].
	mapByte := objectMemory byteAt: mapLocation.
	annotation := mapByte >> AnnotationShift.
	annotation = IsSendCall ifTrue:
		[mapByte := objectMemory byteAt: mapLocation - 1.
		 mapByte >> AnnotationShift = IsAnnotationExtension ifTrue:
			[annotation := annotation + (mapByte bitAnd: DisplacementMask)]].
	^annotation