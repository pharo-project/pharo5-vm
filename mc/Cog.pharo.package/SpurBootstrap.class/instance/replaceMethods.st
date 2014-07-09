bootstrap methods
replaceMethods
	"Replace all the modified method prototypes."
	self allPrototypeClassNamesDo:
		[:sym :symIsMeta| | class |
		class := self findClassNamed: (literalMap at: sym).
		symIsMeta ifTrue: [class := oldHeap fetchClassOfNonImm: class].
		self prototypeClassNameMetaSelectorMethodDo:
			[:className :isMeta :selector :method| | replacement methodDict index |
			(className = sym
			 and: [symIsMeta = isMeta]) ifTrue:
				[(installedPrototypes includes: method selector) ifFalse:
					["probe method dictionary of the class for each method, installing a dummy if not found."
					Transcript
						cr;
						nextPutAll: 'replacing ';
						nextPutAll: className;
						nextPutAll: (isMeta ifTrue: [' class>>'] ifFalse: ['>>']);
						nextPutAll: selector printString;
						flush.
					replacement := self installableMethodFor: method
										selector: selector
										className: className
										isMeta: isMeta.
					methodDict := oldHeap fetchPointer: MethodDictionaryIndex ofObject: class.
					index := self indexOfSelector: (literalMap at: selector) in: methodDict.
					oldHeap
						storePointer: index - SelectorStart
						ofObject: (oldHeap fetchPointer: MethodArrayIndex ofObject: methodDict)
						withValue: replacement.
					installedPrototypes add: method selector]]]]