accessing beziers
bzEndY: index put: value
	^self wbStackValue: self wbStackSize - index + 5 put: value