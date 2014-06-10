accessing stack
wbStackValue: index put: value

	^workBuffer at: self wbTopGet + index put: value