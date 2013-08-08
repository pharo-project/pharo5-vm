initialize
computeSignatureFor: selector from: tuple
	| signature |
	self assert: tuple first == #forMap.
	signature := tuple third collect:
					[:className|
					(Smalltalk classNamed: className)
						ifNil: [self error: 'Argument class' , className, ' does not exist']
						ifNotNil:
							[:argClass|
							argClass
								ccg: self
								prolog: true
								expr: [interpreterProxy primitiveFail]
								index: nil]].
	^signatureMap
		at: tuple second asSymbol
		put: {	selector.
				signature.
				tuple fourth
					ifNil: [[:oop| oop]]
					ifNotNil:
						[:rcvrClassSymbol|
						(Smalltalk classNamed: rcvrClassSymbol)
							ifNil: [self error: 'Receiver class' , rcvrClassSymbol, ' does not exist']
							ifNotNil:
								[:rcvrClass|
								rcvrClass
									ccg: self
									prolog: false
									expr: [interpreterProxy primitiveFail]
									index: nil]] }