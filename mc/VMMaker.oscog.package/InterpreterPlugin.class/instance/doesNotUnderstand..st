simulation support
doesNotUnderstand: aMessage
	<doNotGenerate>
	"Override doesNotUnderstand: to iuntercept sends of translated primitive selectors.
	 The translated primitives are primitives derived from the primitive methods themselves
	 translating their failure code/method body into Slang code."
	(self methodAndTypesOrNilForTranslatedPrimitiveSelector: aMessage selector)
		ifNil: [^super doesNotUnderstand: aMessage]
		ifNotNil:
			[:tuple| | method |
			 method := tuple first.
			 tuple second
				ifNil: [interpreterProxy primitiveFail]
				ifNotNil:
					[:types|
					 self tryToRunTranslatedPrimitive: method types: types subsidiaries: tuple third].
			(#(	compare:with:collated:
				findFirstInString:inSet:startingAt:
				findSubstring:in:startingAt:matchTable:
				hashBytes:startingWith:
				indexOfAscii:inString:startingAt:
				translate:from:to:table:
				compress:toByteArray:
				decompress:fromByteArray:at:)
					includes: method selector) ifFalse:
				[interpreterProxy transcript print: method; cr.
				 interpreterProxy coInterpreter printExternalHeadFrame].
			 interpreterProxy failed ifTrue:
				[interpreterProxy transcript
					nextPutAll: 'WARNING! Failing translated primitive ';
					nextPutAll: aMessage selector;
					nextPutAll: ' implemented by ';
					nextPutAll: method methodClass name;
					nextPutAll: '>>';
					nextPutAll: method selector;
					cr;
					flush]]