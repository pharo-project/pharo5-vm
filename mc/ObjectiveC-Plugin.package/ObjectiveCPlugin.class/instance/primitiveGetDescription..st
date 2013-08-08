system primitives
primitiveGetDescription: aClassOrInstanceOop
	|  classOrInstanceObject utf8String utf8StringOop nsStringObject |
	self primitive: 'primitiveGetDescription'
		parameters: #(Oop).
	self var: 'classOrInstanceObject' declareC: 'id classOrInstanceObject'.
	self var: 'nsStringObject' declareC: 'NSString* nsStringObject'.
	self var: 'utf8String' declareC: 'const char * utf8String'.

	classOrInstanceObject := self cCoerce: (interpreterProxy positive64BitValueOf: aClassOrInstanceOop) to: 'id'.
	utf8String := nil.
	interpreterProxy failed ifTrue: [^nil].
	self touch: nsStringObject.
	self cCode: '    NS_DURING'. 
	self cCode:  'nsStringObject = [classOrInstanceObject description];
				utf8String = [nsStringObject UTF8String]'.
	self cCode: '    NS_HANDLER 
		utf8String = nil;'.
	self cCode: '    NS_ENDHANDLER'.
	utf8String
		ifFalse: [interpreterProxy success: false.
		^nil].
	utf8StringOop := self stringFromCString: utf8String.
	^utf8StringOop
