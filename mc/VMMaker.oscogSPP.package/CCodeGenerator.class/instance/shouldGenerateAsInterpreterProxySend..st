utilities
shouldGenerateAsInterpreterProxySend: aSendNode
	^(self messageReceiverIsInterpreterProxy: aSendNode)
	  and: [(VMBasicConstants mostBasicConstantSelectors includes: aSendNode selector) not]