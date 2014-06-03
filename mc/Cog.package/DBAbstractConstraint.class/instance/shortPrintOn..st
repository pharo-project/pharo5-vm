printing
shortPrintOn: aStream

	aStream nextPutAll: self class name, '(', self printString, ')'.