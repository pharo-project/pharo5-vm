method map
generateMapAt: addressOrNull start: startAddress
	"Generate the method map at addressrNull (or compute it if adressOrNull is null).
	 Answer the length of the map in byes.  Each entry in the map is in two parts.  In the
	 least signficant bits are a displacement of how far from the start or previous entry.
	 In the most signficant bits are the type of annotation at the point reached.  A null
	 byte ends the map."
	| length location |
	<var: #annotation type: #'InstructionAnnotation *'>
	length := 0.
	location := startAddress.
	0 to: annotationIndex - 1 do:
		[:i| | annotation mcpc delta maxDelta mapEntry |
		 annotation := self addressOf: (annotations at: i).
		 mcpc := annotation instruction address + annotation instruction machineCodeSize.
		 [(delta := mcpc - location) > MaxUnitDisplacement] whileTrue:
			[maxDelta := (delta min: MaxX2NDisplacement) bitClear: DisplacementMask.
			 self assert: maxDelta >> AnnotationShift <= DisplacementMask.
			 addressOrNull ~= 0 ifTrue:
				[objectMemory
					byteAt: addressOrNull - length
					put: maxDelta >> AnnotationShift + DisplacementX2N.
				 self traceMap: IsDisplacementX2N
					  byte: maxDelta >> AnnotationShift + DisplacementX2N
					  at: addressOrNull - length
					  for: mcpc].
			 location := location + maxDelta.
			 length := length + 1].
		 addressOrNull ~= 0 ifTrue:
			[mapEntry := delta + (annotation annotation << AnnotationShift).
			 objectMemory byteAt: addressOrNull - length put: mapEntry.
			 self traceMap: annotation
				  byte: mapEntry
				  at: addressOrNull - length
				  for: mcpc].
		 location := location + delta.
		 length := length + 1].
	addressOrNull ~= 0 ifTrue:
		[objectMemory byteAt: addressOrNull - length put: MapEnd.
		 self traceMap: MapEnd
			  byte: MapEnd
			  at: addressOrNull - length
			  for: 0].
	^length + 1