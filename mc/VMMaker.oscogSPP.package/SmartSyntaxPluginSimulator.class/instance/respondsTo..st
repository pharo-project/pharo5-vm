message forwarding
respondsTo: aSelector
	^(signatureMap notNil and: [signatureMap includesKey: aSelector])
	  or: [super respondsTo: aSelector]