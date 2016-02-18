bootstrap methods
addNewMethods
	"Get the simulator to add any and all missing methods immediately."
	| cmaiaSym basSym |
	cmaiaSym := self findSymbol: #compiledMethodAt:ifAbsent:.
	basSym := self findSymbol: #basicAddSelector:withMethod:.
	basSym ifNil:
		[basSym := self findSymbol: #addSelectorSilently:withMethod:].
	self allPrototypeClassNamesDo:
		[:sym :symIsMeta|
		(self findClassNamed: (literalMap at: sym))
			ifNil: [Transcript
					cr;
					nextPutAll: 'not installing any methods for ';
					nextPutAll: sym;
					nextPutAll: '; class not found in image';
					flush.]
			ifNotNil:
				[:theClass| | class |
				class := symIsMeta ifTrue: [oldHeap fetchClassOfNonImm: theClass] ifFalse: [theClass].
				self prototypeClassNameMetaSelectorMethodDo:
					[:className :isMeta :selector :method| | methodOrNil |
					(className = sym
					 and: [symIsMeta = isMeta
					 and: [(method pragmaAt: #remove) isNil]]) ifTrue:
						["probe method dictionary of the class for each method, installing a dummy if not found."
						 "Transcript cr; nextPutAll: 'checking for '; nextPutAll: selector; flush."
						 methodOrNil := self interpreter: oldInterpreter
											object: class
											perform: cmaiaSym
											withArguments: {literalMap at: selector. oldHeap nilObject}.
						 methodOrNil = oldHeap nilObject
							ifTrue: "no method.  install the real thing now"
								[Transcript
									cr;
									nextPutAll: 'installing ';
									nextPutAll: className;
									nextPutAll: (isMeta ifTrue: [' class>>'] ifFalse: ['>>']);
									store: selector;
									flush.
								 self interpreter: oldInterpreter
									object: class
									perform: basSym
									withArguments: { literalMap at: selector.
													   self installableMethodFor: method
														selector: selector
														className: className
														isMeta: isMeta}.
								installedPrototypes add: method selector]
							ifFalse: "existing method; collect the methodClassAssociation; its needed later"
								[methodClasses add: (oldInterpreter methodClassAssociationOf: methodOrNil)]]]]]