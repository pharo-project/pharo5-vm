code editing
process: code
	| range kwd |
	[index <= ranges size] whileTrue:
		[range := ranges at: index.
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
					(kwdxlation includesKey: kwd) ifTrue:
						[output nextPutAll: (kwdxlation at: kwd).
						 codeIndex := range end + 1]]
					ifFalse:
						[[codeIndex <= range end] whileTrue:
							[output nextPut: (code at: codeIndex).
							 codeIndex := codeIndex + 1].
						"kill whitespace after up-arrow in ^ expr"
						(range type == #return and: [index <= ranges size]) ifTrue:
							[codeIndex := (ranges at: index) start]]]]