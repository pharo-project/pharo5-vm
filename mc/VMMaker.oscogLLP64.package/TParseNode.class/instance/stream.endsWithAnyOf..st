testing
stream: aStream endsWithAnyOf: characters
	"Answer if the given stream ends in any of the characters, ignoring whitespace."
	| pos ch popped |
	pos := aStream position.
	aStream class = WriteStream ifTrue: "i.e. nested in StreamContents"
		[[pos > 0] whileTrue:
			[ch := aStream originalContents at: pos.
			 ch isSeparator ifFalse:
				[^characters includes: ch].
			 pos := pos - 1].
		 ^false].

	popped := OrderedCollection new.
	[pos > 0] whileTrue:
		[ch := popped addFirst: (aStream position: pos - 1; peek).
		 ch isSeparator ifFalse:
			[popped notEmpty ifTrue: "it almost always is"
				["*don't* use nextPutAll: to work around a bug in UTF8TextConverter
				  >>nextPut:toStream: which avoids line-end conversion; sigh."
				 popped do:
					[:c| aStream nextPut: c]].
			 ^characters includes: ch].
		 pos := pos - 1].
	"*don't* use nextPutAll: to work around a bug in UTF8TextConverter>>
	 nextPut:toStream: which avoids line-end conversion; sigh."
	popped do:
		[:c| aStream nextPut: c].
	^false