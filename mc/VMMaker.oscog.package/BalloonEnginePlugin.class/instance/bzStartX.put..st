accessing beziers
bzStartX: index put: value
	^self wbStackValue: self wbStackSize - index + 0 put: value