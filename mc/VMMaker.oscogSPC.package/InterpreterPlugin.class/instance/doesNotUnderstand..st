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
			 "First check the cache for validity; if the ast element of the tuple is the actual method
			 then the cache is up-to-date.  if it is not, the method has changed and should be regenerated."
			 method := tuple last.
			 method == (method methodClass >> method selector) ifFalse:
				[translatedMethodCache removeKey: aMessage selector.
				 ^self doesNotUnderstand: aMessage].
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