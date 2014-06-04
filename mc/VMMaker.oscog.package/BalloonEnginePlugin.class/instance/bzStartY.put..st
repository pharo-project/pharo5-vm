accessing beziers
bzStartY: index put: value
	^self wbStackValue: self wbStackSize - index + 1 put: value