utilities
pitchForName: aString
	"AbstractSound pitchForName: 'c2'"
	"#(c 'c#' d eb e f fs g 'g#' a bf b) collect: [ :s | AbstractSound pitchForName: s, '4']"

	| s modifier octave i j noteName p |
	s := ReadStream on: aString.
	modifier := $n.
	noteName := s next.
	(s atEnd not and: [s peek isDigit]) ifFalse: [ modifier := s next ].
	s atEnd
		ifTrue: [ octave := 4 ]
		ifFalse: [ octave := Integer readFrom: s ].
	octave < 0 ifTrue: [ self error: 'cannot use negative octave number' ].
	i := 'cdefgab' indexOf: noteName.
	i = 0 ifTrue: [ self error: 'bad note name: ', noteName asString ].
	i := #(2 4 6 7 9 11 13) at: i.
	j := 's#fb' indexOf: modifier.
	j = 0 ifFalse: [ i := i + (#(1 1 -1 -1) at: j) ].  "i is now in range: [1..14]"
	"Table generator: (1 to: 14) collect: [ :i | 16.3516 * (2.0 raisedTo: (i - 2) asFloat / 12.0)]"
	p := #(15.4339 16.3516 17.3239 18.354 19.4454 20.6017 21.8268 23.1247 24.4997 25.9565 27.5 29.1352 30.8677 32.7032) at: i.
	octave timesRepeat: [ p := 2.0 * p ].
	^ p
