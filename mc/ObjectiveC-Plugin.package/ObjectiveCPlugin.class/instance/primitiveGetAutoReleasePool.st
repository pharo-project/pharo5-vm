system primitives
primitiveGetAutoReleasePool
	|  pool |
	self primitive: 'primitiveGetAutoReleasePool'.
	self var: 'pool' declareC: 'NSAutoreleasePool * pool'.
	pool := nil.
	self cCode: '    NS_DURING'. 
	self cCode:  'pool = [NSAutoreleasePool new]'.
	self cCode: '    NS_HANDLER 
		pool = nil;'.
	self cCode: '    NS_ENDHANDLER'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: pool to: 'usqInt') 