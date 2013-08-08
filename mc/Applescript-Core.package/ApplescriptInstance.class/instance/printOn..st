printing
printOn: aStream

	aStream 
		nextPutAll: 'an ';
		nextPutAll: self species asString;
		nextPutAll: '(';
		nextPutAll: self scriptingName;
		nextPutAll: ')'