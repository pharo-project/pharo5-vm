C translation
generatePlus: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."
	(self generateAsConstantExpression: msgNode on: aStream) ifFalse:
		[self emitCExpression: msgNode receiver on: aStream.
		 aStream nextPutAll: ' + '.
		 self emitCExpression: msgNode args first on: aStream]