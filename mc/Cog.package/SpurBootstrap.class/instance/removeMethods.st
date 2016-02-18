bootstrap methods
removeMethods
	"Get the simulator to remove any methods marked with <remove>."
	| removeSym |
	removeSym := self findSymbol: #removeSelectorSilently:.
	removeSym ifNil:
		[removeSym := self findSymbol: #removeSelector:].
	self prototypeClassNameMetaSelectorMethodDo:
		[:className :isMeta :selector :method| | class |
		(method pragmaAt: #remove) ifNotNil:
			[(self findClassNamed: (literalMap at: className)) ifNotNil:
				[:theClass|
				 class := isMeta ifTrue: [oldHeap fetchClassOfNonImm: theClass] ifFalse: [theClass].
				 Transcript
					cr;
					nextPutAll: 'removing ';
					nextPutAll: className;
					nextPutAll: (isMeta ifTrue: [' class>>'] ifFalse: ['>>']);
					store: selector;
					flush.
				 self interpreter: oldInterpreter
					object: class
					perform: removeSym
					withArguments: {literalMap at: selector}]]]