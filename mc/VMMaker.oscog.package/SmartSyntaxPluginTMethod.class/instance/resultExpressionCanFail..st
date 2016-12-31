private
resultExpressionCanFail: aTSendNode
	"Neither asSmallIntegerObj nor asBooleanObj can fail."
	^(#(asSmallIntegerObj asBooleanObj) includes: aTSendNode selector) not