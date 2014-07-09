disassembly
instructionSequence
	^Array streamContents:
		[:s|
		labels with: instructions do:
			[:label :inst|
			inst ifNotNil:
				[label ~~ false ifTrue:
					[s nextPut: label].
				s nextPut: inst]]]