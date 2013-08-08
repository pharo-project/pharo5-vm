accessing beziers
bzViaX: index put: value
	^self wbStackValue: self wbStackSize - index + 2 put: value