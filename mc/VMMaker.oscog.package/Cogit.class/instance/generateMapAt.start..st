method map
generateMapAt: addressOrNull start: startAddress
	"Generate the method map at addressrNull (or compute it if addressOrNull is null).
	 Answer the length of the map in byes.  Each entry in the map is in two parts.  In the
	 least signficant bits are a displacement of how far from the start or previous entry,
	 unless it is an IsAnnotationExtension byte, in which case those bits are the extension.
	 In the most signficant bits are the type of annotation at the point reached.  A null
	 byte ends the map."
	| length location |
	<var: #instruction type: #'AbstractInstruction *'>
	length := 0.
	location := startAddress.
	0 to: opcodeIndex - 1 do:
		[:i| | instruction mcpc delta maxDelta mapEntry |
		instruction := self abstractInstructionAt: i.
		instruction annotation ifNotNil:
			[:annotation|
			 literalsManager assertValidAnnotation: annotation for: instruction.
			 mcpc := instruction mapEntryAddress.
			 [(delta := mcpc - location / backEnd codeGranularity) > DisplacementMask] whileTrue:
				[maxDelta := (delta min: MaxX2NDisplacement) bitClear: DisplacementMask.
				 self assert: maxDelta >> AnnotationShift <= DisplacementMask.
				 addressOrNull ifNotNil:
					[self addToMap: IsDisplacementX2N
						instruction: instruction
						byte: maxDelta >> AnnotationShift + DisplacementX2N
						at: addressOrNull - length
						for: mcpc].
				 location := location + (maxDelta * backEnd codeGranularity).
				 length := length + 1].
			 addressOrNull ifNotNil:
				[mapEntry := delta + ((annotation min: IsSendCall) << AnnotationShift).
				 self addToMap: annotation instruction: instruction byte: mapEntry at: addressOrNull - length for: mcpc].
			 location := location + (delta * backEnd codeGranularity).
			 length := length + 1.
			 annotation > IsSendCall ifTrue: "Add the necessary IsAnnotationExtension"
				[addressOrNull ifNotNil:
					[mapEntry := IsAnnotationExtension << AnnotationShift + (annotation - IsSendCall).
					 self addToMap: annotation instruction: instruction byte: mapEntry at: addressOrNull - length for: mcpc].
				 length := length + 1]]].
	addressOrNull ifNotNil:
		[self addToMap: MapEnd instruction: nil byte: MapEnd at: addressOrNull - length for: 0].
	^length + 1