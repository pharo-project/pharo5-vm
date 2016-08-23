simulation
methodAndTypesOrNilForTranslatedPrimitiveSelector: selector
	<doNotGenerate>
	"If selector maps to a simulateable translated primitive method, then
	 answer the method and its types for selector, the selector of a translated primitive.
	 Otherwise answer nil.  This caches the results of analysis in translatedMethodCache."
	translatedMethodCache ifNil:
		[translatedMethodCache := IdentityDictionary new.
		 translatedMethodCache at: #CCodeGenerator put: CCodeGenerator new].
	^translatedMethodCache
		at: selector
		ifAbsentPut: [self tupleOrNilForTranslatedPrimitiveSelector: selector]