utilities
messageReceiverIsInterpreterProxy: sendNode
	^self isGeneratingPluginCode
	  and: [sendNode receiver isVariable
	  and: ['interpreterProxy' = sendNode receiver name
	  and: [(self isKernelSelector: sendNode selector) not]]]