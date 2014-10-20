utilities
shouldGenerateAsInterpreterProxySend: aSendNode
	^(self messageReceiverIsInterpreterProxy: aSendNode)
	  and: [(self mostBasicConstantSelectors includes: aSendNode selector) not]