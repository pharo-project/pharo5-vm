system primitives
primitiveGetObjCClassForString: aClassName
	| classNameLength classNameNSString classObject |
	self primitive: 'primitiveGetObjCClassForString'
		parameters: #(Symbol).
	self var: 'classObject' declareC: 'Class classObject'.
	self var: 'classNameNSString' declareC: 'NSString* classNameNSString'.

	classNameLength := interpreterProxy slotSizeOf: aClassName cPtrAsOop.
	self touch: classNameLength.
	classNameNSString := self cCode: '[[NSString alloc] initWithBytes: aClassName length: classNameLength encoding: NSUTF8StringEncoding]'.
	self cCode: '    NS_DURING'. 
	classObject := classNameNSString NSClassFromString.
	self cCode: '    NS_HANDLER 
	classObject = nil;'.
	self cCode: '    NS_ENDHANDLER'.
	self cCode: '[classNameNSString release]'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: classObject to: 'usqInt') 