adding/removing methods
basicRemoveSelector: aSelector
	"Override to update the timeStamp"
	^(super basicRemoveSelector: aSelector) ifNotNil:
		[:oldMethod| self touch. oldMethod]