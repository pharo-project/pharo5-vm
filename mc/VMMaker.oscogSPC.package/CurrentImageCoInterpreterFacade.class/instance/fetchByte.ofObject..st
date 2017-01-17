accessing
fetchByte: index ofObject: anOop
	^(self objectForOop: anOop)
		at: index + 1
		ifAbsent:
			[Transcript
				ensureCr;
				nextPutAll: 'warning, accessing past end of '; print: (objectMap keyAtValue: anOop);
				cr;
				flush.
			255]