reporting
report: name time: millisecs reference: reference on: aStream
	aStream
		cr;
		nextPutAll: name; cr;
		nextPutAll: ' took '; print: millisecs / 1000.0; nextPutAll: ' seconds'; cr; flush;
		nextPutAll: 'ratio: '; print: ((millisecs / reference) roundTo: 0.001);
		nextPutAll: '   % change: '; print: ((millisecs - reference * 100 / reference) roundTo: 0.01); nextPut: $%;
		cr; flush