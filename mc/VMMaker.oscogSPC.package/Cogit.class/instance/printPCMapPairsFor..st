method map
printPCMapPairsFor: cogMethod
	<api>
	<var: 'cogMethod' type: #'CogMethod *'>
	<var: 'mapByte' type: #'unsigned char'>
	| mcpc map mapByte annotation value |
	mcpc := self firstMappedPCFor: cogMethod.
	map := self mapStartFor: cogMethod.
	[(mapByte := objectMemory byteAt: map) ~= MapEnd] whileTrue:
		[annotation := mapByte >> AnnotationShift.
		 annotation = IsAnnotationExtension
			ifTrue:
				[value := (mapByte bitAnd: DisplacementMask) + IsSendCall]
			ifFalse:
				[value := annotation.
				 mcpc := mcpc + (backEnd codeGranularity
									* (annotation = IsDisplacementX2N
										ifTrue: [mapByte - DisplacementX2N << AnnotationShift]
										ifFalse: [mapByte bitAnd: DisplacementMask]))].
		 coInterpreter
			printHexnp: map;
		 	print: ': '.
		 self
			cCode: [self print: '%02x' f: mapByte]
			inSmalltalk:
				[mapByte < 16 ifTrue:
					[coInterpreter putchar: $0].
				 coInterpreter printHexnp: mapByte].
		 coInterpreter
		 	printChar: $ ;
			printNum: annotation;
			print: ' ('.
		 NewspeakVM
			ifTrue:
				[value
					caseOf: {
						[IsDisplacementX2N]		->	[coInterpreter print: 'IsDisplacementX2N'].
						[IsAnnotationExtension]		->	[coInterpreter print: 'IsAnnotationExtension'].
						[IsObjectReference]		->	[coInterpreter print: 'IsObjectReference'].
						[IsAbsPCReference]		->	[coInterpreter print: 'IsAbsPCReference'].
						[HasBytecodePC]			->	[coInterpreter print: 'HasBytecodePC'].
						[IsRelativeCall]				->	[coInterpreter print: 'IsRelativeCall'].
						[IsNSSendCall]				->	[coInterpreter print: 'IsNSSendCall'].
						[IsSendCall]					->	[coInterpreter print: 'IsSendCall'].
						[IsSuperSend]				->	[coInterpreter print: 'IsSuperSend'].
						[IsDirectedSuperSend]		->	[coInterpreter print: 'IsDirectedSuperSend'].
						[IsNSSelfSend]				->	[coInterpreter print: 'IsNSSelfSend'].
						[IsNSDynamicSuperSend]	->	[coInterpreter print: 'IsNSDynamicSuperSend'].
						[IsNSImplicitReceiverSend]	->	[coInterpreter print: 'IsNSImplicitReceiverSend'] }
					otherwise: [coInterpreter print: '??? '; printHexnp: value]]
			ifFalse:
				[value
					caseOf: {
						[IsDisplacementX2N]		->	[coInterpreter print: 'IsDisplacementX2N'].
						[IsAnnotationExtension]		->	[coInterpreter print: 'IsAnnotationExtension'].
						[IsObjectReference]		->	[coInterpreter print: 'IsObjectReference'].
						[IsAbsPCReference]		->	[coInterpreter print: 'IsAbsPCReference'].
						[HasBytecodePC]			->	[coInterpreter print: 'HasBytecodePC'].
						[IsRelativeCall]				->	[coInterpreter print: 'IsRelativeCall'].
						[IsSendCall]					->	[coInterpreter print: 'IsSendCall'].
						[IsSuperSend]				->	[coInterpreter print: 'IsSuperSend'].
						[IsDirectedSuperSend]		->	[coInterpreter print: 'IsDirectedSuperSend'] }
					otherwise: [coInterpreter print: '??? '; printHexnp: value]].
		 coInterpreter
			print: ') ';
			printHexnp: (mapByte bitAnd: DisplacementMask);
			printChar: $ ;
			putchar: $@;
		 printHex: mcpc;
		 cr;
		 flush.
		 map := map - 1]