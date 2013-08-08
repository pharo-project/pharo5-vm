system primitives
primitiveGetNSStringForString: aStringOop encoding: anEncoding
	| stringLength aStringAsNSString encoding aString |
	self primitive: 'primitiveGetNSStringForString'
		parameters: #(Oop Oop).
	self var: 'aStringAsNSString' declareC: 'NSString* aStringAsNSString'.
	self var: 'encoding' declareC: 'NSUInteger encoding'. 
	self var: 'aString' declareC: 'char* aString'. 
	encoding := self cCoerce: (interpreterProxy positive64BitValueOf: anEncoding) to: 'NSUInteger'.
	aString := interpreterProxy firstIndexableField: aStringOop.
	stringLength := interpreterProxy byteSizeOf: aStringOop.
	self touch: stringLength.
	aStringAsNSString := 0.
	self cCode: '    NS_DURING'. 
		aStringAsNSString := self cCode: '[[NSString alloc] initWithBytes: aString length: stringLength encoding: encoding]'.
	self cCode: '    NS_HANDLER 
				aStringAsNSString = nil;'.
	self cCode: '    NS_ENDHANDLER'.
	^interpreterProxy positive64BitIntegerFor: (self cCoerce: aStringAsNSString to: 'usqInt') 