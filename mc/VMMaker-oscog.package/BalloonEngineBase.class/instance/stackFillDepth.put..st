accessing fills
stackFillDepth: index put: value
	^self wbStackValue: index+1 put: value