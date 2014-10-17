printing
printOn: aStream
	"Append a string which represents my strength onto aStream."

	aStream nextPutAll: '%', symbolicValue, '%'.