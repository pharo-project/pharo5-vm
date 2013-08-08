printing
printOn: aStream

	aStream 
		nextPutAll: self species asString;
		nextPutAll: '(''';
		nextPutAll: (self fourBytesAt: 1);
		nextPutAll: ''')'