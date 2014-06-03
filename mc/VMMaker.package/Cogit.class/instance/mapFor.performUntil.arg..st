method map
mapFor: cogMethod performUntil: functionSymbol arg: arg
	"Unlinking/GC/Disassembly support"
	<var: #cogMethod type: #'CogMethod *'>
	<var: #functionSymbol declareC: 'int (*functionSymbol)(sqInt annotation, char *mcpc, sqInt arg)'>
	<inline: true>
	| mcpc map mapByte result |
	mcpc := cogMethod asInteger + cmNoCheckEntryOffset.
	map := self mapStartFor: cogMethod.
	[(mapByte := coInterpreter byteAt: map) ~= MapEnd] whileTrue:
		[mapByte >= FirstAnnotation
			ifTrue:
				[mcpc := mcpc + (mapByte bitAnd: DisplacementMask).
				 result := self perform: functionSymbol
							   with: mapByte >> AnnotationShift
							   with: (self cCoerceSimple: mcpc to: #'char *')
							   with: arg.
				 result ~= 0 ifTrue:
					[^result]]
			ifFalse:
				[mcpc := mcpc + (mapByte >= DisplacementX2N
									ifTrue: [mapByte - DisplacementX2N << AnnotationShift]
									ifFalse: [mapByte])].
		 map := map - 1].
	^0