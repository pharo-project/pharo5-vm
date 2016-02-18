munging
replaceMethods
	| byteSymbolClassIndex symbols symbolSizes |
	byteSymbolClassIndex := heap classIndexOf: (heap splObj: SelectorDoesNotUnderstand).
	symbols := Set with: #bindingOf:.
	replacements do:
		[:tuple| | method adder |
		symbols add: tuple second.
		method := tuple last.
		adder := [:lit|
				   (lit isSymbol and: [lit ~~ method selector]) ifTrue: [symbols add: lit].
				   (lit isVariableBinding and: [lit key isSymbol]) ifTrue: [symbols add: lit key].
				   lit isArray ifTrue: [lit do: adder]].
		method literals do: adder].
	symbolSizes := symbols collect: [:ea| ea size].
	symbolOops := Dictionary new.
	heap allObjectsDo:
		[:obj| | sz |
		((heap classIndexOf: obj) = byteSymbolClassIndex
		 and: [symbolSizes includes: (sz := heap numBytesOf: obj)]) ifTrue:
			[symbols do:
				[:s|
				 (sz = s size
				  and: [(interpreter stringOf: obj) = s]) ifTrue:
					[symbolOops at: s put: obj]]]].
	replacements do:
		[:tuple|
		[:classOop :selector :method| | replacement methodDict methodArray index |
		methodDict := heap fetchPointer: MethodDictionaryIndex ofObject: classOop.
		methodArray := heap fetchPointer: MethodArrayIndex ofObject: methodDict.
		index := (0 to: (heap numSlotsOf: methodArray) - 1) detect: [:i| (heap fetchPointer: i ofObject: methodArray) ~= heap nilObject].
		replacement := self installableMethodFor: method
							selector: (symbolOops at: selector)
							siblingMethod: (heap fetchPointer: index ofObject: methodArray).
		index := self indexOfSelector: (symbolOops at: selector) in: methodDict.
		heap
			storePointer: index - SelectorStart
			ofObject: methodArray
			withValue: replacement] valueWithArguments: tuple]