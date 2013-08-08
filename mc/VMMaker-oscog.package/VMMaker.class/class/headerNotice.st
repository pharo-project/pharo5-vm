version testing
headerNotice
"return a string to be put at the front of generated code files"
	^String streamContents:[:strm|
		strm nextPutAll: 'Automatically generated from Squeak on '.
		strm nextPutAll: Time dateAndTimeNow printString.
		strm cr.
		strm nextPutAll: 'by VMMaker '.
		strm nextPutAll: self  versionString.
		strm cr]