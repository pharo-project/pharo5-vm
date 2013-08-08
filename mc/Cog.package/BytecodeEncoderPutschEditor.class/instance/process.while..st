code editing
process: code while: aBlock
	| range mapOnToEncoder kwd |
	mapOnToEncoder := false.
	[index <= ranges size] whileTrue:
		[range := ranges at: index.
		  (aBlock value: range) ifFalse:
			[^self].
		 index := index + 1.
		 [codeIndex < range start] whileTrue:
			[output nextPut: (code at: codeIndex).
			 codeIndex := codeIndex + 1].
		range type == #assignment
			ifTrue: [output nextPutAll: ':='.
					codeIndex := range end + 1]
			ifFalse:
				[(#(keyword patternKeyword) includes: range type) ifTrue:
					[kwd := code copyFrom: range start to: range end.
					(mapOnToEncoder and: [kwd = 'on:'])
						ifTrue:
							[output nextPutAll: 'encoder: encoder'.
							 mapOnToEncoder := false.
							 codeIndex := (ranges at: index) end + 1.
							 index := index + 1]
						ifFalse:
							[(kwdxlation includesKey: kwd) ifTrue:
								[(kwd beginsWith: 'emit') ifTrue:
									[mapOnToEncoder := true].
								 output nextPutAll: (kwdxlation at: kwd).
								 codeIndex := range end + 1]]]
					ifFalse:
						[[codeIndex <= range end] whileTrue:
							[output nextPut: (code at: codeIndex).
							 codeIndex := codeIndex + 1].
						"kill whitespace after up-arrow in ^ expr"
						(range type == #return and: [index <= ranges size]) ifTrue:
							[codeIndex := (ranges at: index) start]]]]