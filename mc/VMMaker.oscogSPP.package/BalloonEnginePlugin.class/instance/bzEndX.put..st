accessing beziers
bzEndX: index put: value
	^self wbStackValue: self wbStackSize - index + 4 put: value