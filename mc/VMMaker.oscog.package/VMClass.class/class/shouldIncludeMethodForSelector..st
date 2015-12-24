translation
shouldIncludeMethodForSelector: selector
	"Answer whether a primitive method shoud be translated.  Emit a warning to the transcript if the method doesn't exist."
	^(self whichClassIncludesSelector: selector)
		ifNotNil:
			[:c|
			 (c >> selector pragmaAt: #option:)
				ifNotNil:
					[:pragma|
					 initializationOptions at: (pragma arguments first) ifAbsent: [true]]
				ifNil: [true]]
		ifNil:
			[Transcript nextPutAll: 'Cannot find implementation of '; nextPutAll: selector; nextPutAll: ' in hierarchy of '; print: self; cr; flush.
			 false]