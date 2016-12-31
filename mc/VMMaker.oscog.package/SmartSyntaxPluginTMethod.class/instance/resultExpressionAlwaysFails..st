private
resultExpressionAlwaysFails: aTSendNode
	^aTSendNode selector == #success:
	 and: [aTSendNode args first isConstant
	 and: [aTSendNode args first value == false]]