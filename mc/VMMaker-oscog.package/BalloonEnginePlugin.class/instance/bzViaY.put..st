accessing beziers
bzViaY: index put: value
	^self wbStackValue: self wbStackSize - index + 3 put: value