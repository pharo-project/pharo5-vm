parsing
breakIntoLines: aString
	^self pruneBogusEmptyLines:
		(Array streamContents:
			[:os| | is ss char |
			is := aString readStream.
			ss := ReadWriteStream on: String new.
			[is atEnd] whileFalse:
				[(char := is next) = Character lf
					ifTrue:
						[os nextPut: ss contents.
						 ss resetContents]
					ifFalse: [ss nextPut: char]].
			ss position > 0 ifTrue:
				[os nextPut: ss contents]])