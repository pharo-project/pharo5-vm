accessing
initialPCForHeader: methodHeaderOop method: aMethodOop
	self assert: (self objectForOop: aMethodOop) == (headerToMethodMap at: methodHeaderOop).
	^{ self objectForOop: aMethodOop. (self objectForOop: aMethodOop) initialPC }