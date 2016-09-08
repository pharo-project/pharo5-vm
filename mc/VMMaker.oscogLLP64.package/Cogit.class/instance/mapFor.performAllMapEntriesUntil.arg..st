method map
mapFor: cogMethod performAllMapEntriesUntil: functionSymbol arg: arg
	"Analysis support"
	<doNotGenerate>
	| mcpc map mapByte result |
	mcpc := self firstMappedPCFor: cogMethod.
	map := self mapStartFor: cogMethod.
	[(mapByte := objectMemory byteAt: map) ~= MapEnd] whileTrue:
		[mapByte >= FirstAnnotation
			ifTrue:
				[mcpc := mcpc + ((mapByte bitAnd: DisplacementMask) * backEnd codeGranularity)]
			ifFalse:
				[mapByte < (IsAnnotationExtension << AnnotationShift) ifTrue:
					[mcpc := mcpc + ((mapByte - DisplacementX2N << AnnotationShift) * backEnd codeGranularity)]].
		 result := self perform: functionSymbol
					   with: mapByte >> AnnotationShift
					   with: (self cCoerceSimple: mcpc to: #'char *')
					   with: arg.
		 result ~= 0 ifTrue:
			[^result].
		 map := map - 1].
	^0