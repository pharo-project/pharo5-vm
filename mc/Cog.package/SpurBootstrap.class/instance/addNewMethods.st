bootstrap methods
addNewMethods
	"Get the simulator to add any and all missing methods immediately."
	| cmaiaSym basSym |
	cmaiaSym := self findSymbol: #compiledMethodAt:ifAbsent:.
	basSym := self findSymbol: #basicAddSelector:withMethod:.
	basSym ifNil:
		[basSym := self findSymbol: #addSelectorSilently:withMethod:].
	self allPrototypeClassNamesDo:
		[:sym :symIsMeta| | class |
		class := self findClassNamed: (literalMap at: sym).
		symIsMeta ifTrue: [class := oldHeap fetchClassOfNonImm: class].
		self prototypeClassNameMetaSelectorMethodDo:
			[:className :isMeta :selector :method| | methodOrNil |
			(className = sym
			 and: [symIsMeta = isMeta]) ifTrue:
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
							nextPutAll: selector printString;
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
						[methodClasses add: (oldInterpreter methodClassAssociationOf: methodOrNil)]]]]