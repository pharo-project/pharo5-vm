method map
mapFor: cogMethod performAllMapEntriesUntil: functionSymbol arg: arg
	"Analysis support"
	<doNotGenerate>
	| mcpc map mapByte result |
	mcpc := cogMethod asInteger + cmNoCheckEntryOffset.
	map := self mapStartFor: cogMethod.
	[(mapByte := coInterpreter byteAt: map) ~= MapEnd] whileTrue:
		[mapByte >= FirstAnnotation
			ifTrue:
				[mcpc := mcpc + (mapByte bitAnd: DisplacementMask)]
			ifFalse:
				[mapByte < (IsAnnotationExtension << AnnotationShift) ifTrue:
					[mcpc := mcpc + (mapByte - DisplacementX2N << AnnotationShift)]].
		 result := self perform: functionSymbol
					   with: mapByte >> AnnotationShift
					   with: (self cCoerceSimple: mcpc to: #'char *')
					   with: arg.
		 result ~= 0 ifTrue:
			[^result].
		 map := map - 1].
	^0