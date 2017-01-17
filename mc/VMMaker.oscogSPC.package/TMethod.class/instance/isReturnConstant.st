testing
isReturnConstant
	^parseTree statements size = 1
	 and: [parseTree statements last isReturn
	 and: [parseTree statements last expression isLeaf]]