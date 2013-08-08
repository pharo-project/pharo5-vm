printing
printOn: aStream

	aStream 
		nextPutAll: self species asString;
		nextPutAll: '('.
	(1 to: self size)
		do: [:i | self printAt: i on: aStream]
		separatedBy: [aStream nextPutAll: '; '].
	aStream nextPut: $)