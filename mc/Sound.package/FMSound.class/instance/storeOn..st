storing
storeOn: strm
	| env |
	strm nextPutAll: '(((FMSound';
		nextPutAll: ' pitch: '; print: self pitch;
		nextPutAll: ' dur: '; print: self duration;
		nextPutAll: ' loudness: '; print: self loudness; nextPutAll: ')';
		nextPutAll: ' modulation: '; print: self modulation;
		nextPutAll: ' ratio: '; print: self ratio; nextPutAll: ')'.
	1 to: envelopes size do:
		[:i | env := envelopes at: i.
		strm cr; nextPutAll: '    addEnvelope: '. env storeOn: strm.
		i < envelopes size ifTrue: [strm nextPutAll: ';']].
	strm  nextPutAll: ')'.
