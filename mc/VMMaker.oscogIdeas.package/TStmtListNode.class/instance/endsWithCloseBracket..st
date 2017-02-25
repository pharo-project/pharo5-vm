testing
endsWithCloseBracket: aStream
	"Answer true if the given stream ends in a $} character."

	| ch pos |
	ch := (pos := aStream position) > 0 ifTrue:
			[aStream class = WriteStream "i.e. nested in StreamContents"
				ifTrue: [aStream originalContents at: pos]
				ifFalse: [aStream position: pos - 1; next]].
	^ ch = $}
