system primitives
primitiveGetSelectorFromString: aSelectorName
	| selectorLength selectorNSString selectorObject |
	self primitive: 'primitiveGetSelectorForString'
		parameters: #(Symbol).
	self var: 'selectorObject' declareC: 'SEL selectorObject'.
	self var: 'selectorNSString' declareC: 'NSString * selectorNSString'.

	selectorLength := interpreterProxy slotSizeOf: aSelectorName cPtrAsOop.
	self touch: selectorLength.
	selectorNSString := self cCode: '[[NSString alloc] initWithBytes: aSelectorName length: selectorLength encoding: NSUTF8StringEncoding]'.
	self cCode: '    NS_DURING'. 
	selectorObject := selectorNSString NSSelectorFromString.
	self cCode: '    NS_HANDLER 
	selectorObject = nil;'.
	self cCode: '    NS_ENDHANDLER'.
	self cCode: '[selectorNSString release]'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: selectorObject to: 'usqInt') 