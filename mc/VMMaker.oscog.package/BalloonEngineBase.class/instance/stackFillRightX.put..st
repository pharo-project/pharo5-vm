accessing fills
stackFillRightX: index put: value
	^self wbStackValue: index+2 put: value