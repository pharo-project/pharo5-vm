C translation
generateTimes: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	(self generateAsConstantExpression: msgNode on: aStream) ifFalse:
		[msgNode args first constantNumbericValueOrNil ifNotNil:
			[:value|
			 value = 0 ifTrue:
				[^self emitCExpression: msgNode args first on: aStream].
			 value = 1 ifTrue:
				[^self emitCExpression: msgNode receiver on: aStream]].
		 self emitCExpression: msgNode receiver on: aStream.
		 aStream nextPutAll: ' * '.
		 self emitCExpression: msgNode args first on: aStream]