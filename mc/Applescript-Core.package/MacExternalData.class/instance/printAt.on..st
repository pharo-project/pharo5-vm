printing
printAt: index on: aStream

	aStream 
		nextPutAll: (self at: index) hex8;
		nextPutAll: '(''';
		nextPutAll: (self fourBytesAt: index);
		nextPutAll: ''')'