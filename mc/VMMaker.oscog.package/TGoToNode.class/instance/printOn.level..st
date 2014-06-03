printing
printOn: aStream level: level

	aStream nextPutAll: 'goto '.
	aStream nextPutAll: label.