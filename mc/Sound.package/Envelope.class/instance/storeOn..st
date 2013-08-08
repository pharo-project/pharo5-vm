storing
storeOn: strm
	strm nextPutAll: '((' , self class name;
		nextPutAll: ' points: '; store: (points collect: [:p | p x @ (p y roundTo: 0.00001)]);
		nextPutAll: ' loopStart: '; print: loopStartIndex;
		nextPutAll: ' loopEnd: '; print: loopEndIndex; nextPutAll: ')';
		nextPutAll: ' updateSelector: '; store: self updateSelector; nextPutAll: ';';
		nextPutAll: ' scale: '; print: scale; nextPutAll: ')'.
