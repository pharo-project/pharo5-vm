system primitives
primitiveNSStringToUTF8: aNSStringOop
	|  nsStringObject utf8String utf8StringOop |
	self primitive: 'primitiveNSStringToUTF8'
		parameters: #(Oop).
	self var: 'nsStringObject' declareC: 'NSString* nsStringObject'.
	self var: 'utf8String' declareC: 'const char * utf8String'.

	nsStringObject := self cCoerce: (interpreterProxy positive64BitValueOf: aNSStringOop) to: 'NSString *'.
	interpreterProxy failed ifTrue: [^nil].
	utf8String := nil.
	self touch: nsStringObject.
	self cCode: '    NS_DURING'. 
	self cCode:  'utf8String = [nsStringObject UTF8String]'.
	self cCode: '    NS_HANDLER 
		utf8String = nil;'.
	self cCode: '    NS_ENDHANDLER'.
	utf8String
		ifFalse: [interpreterProxy success: false.
		^nil].
	utf8StringOop := self stringFromCString: utf8String.
	^utf8StringOop
