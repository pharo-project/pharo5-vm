method map
mapFor: cogMethod performUntil: functionSymbol arg: arg
	"Unlinking/GC/Disassembly support"
	<var: #cogMethod type: #'CogMethod *'>
	<var: #functionSymbol declareC: 'int (*functionSymbol)(sqInt annotation, char *mcpc, sqInt arg)'>
	<inline: true>
	| mcpc map mapByte annotation result |
	mcpc := cogMethod asInteger + cmNoCheckEntryOffset.
	map := self mapStartFor: cogMethod.
	[(mapByte := objectMemory byteAt: map) ~= MapEnd] whileTrue:
		[mapByte >= FirstAnnotation
			ifTrue:
				[mcpc := mcpc + ((mapByte bitAnd: DisplacementMask) * backEnd codeGranularity).
				 "If this is an IsSendCall annotation, peek ahead for an IsAnnotationExtension, and consume it."
				 ((annotation := mapByte >> AnnotationShift) = IsSendCall
				  and: [(mapByte := objectMemory byteAt: map - 1) >> AnnotationShift = IsAnnotationExtension]) ifTrue:
					[annotation := annotation + (mapByte bitAnd: DisplacementMask).
					 map := map - 1].
				 result := self perform: functionSymbol
							   with: annotation
							   with: (self cCoerceSimple: mcpc to: #'char *')
							   with: arg.
				 result ~= 0 ifTrue:
					[^result]]
			ifFalse:
				[mapByte < (IsAnnotationExtension << AnnotationShift) ifTrue:
					[mcpc := mcpc + ((mapByte - DisplacementX2N << AnnotationShift) * backEnd codeGranularity)]].
		 map := map - 1].
	^0