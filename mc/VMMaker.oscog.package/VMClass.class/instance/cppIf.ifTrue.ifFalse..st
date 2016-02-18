translation support
cppIf: conditionBlockOrSymbolValue ifTrue: trueExpressionOrBlock ifFalse: falseExpressionOrBlockOrNil
	"When translated, produces #if (condition) #else #endif CPP directives.
	 Example usage:

		self cppIf: [BytesPerWord = 8]
			ifTrue: [self doSomethingFor64Bit]
			ifFalse: [self doSomethingFor32Bit]
		self cppIf: BytesPerWord = 8
			ifTrue: [self doSomethingFor64Bit]
			ifFalse: [self doSomethingFor32Bit]
		self cppIf: #A_GLOBAL
			ifTrue: [self doSomethingFor64Bit]
			ifFalse: [self doSomethingFor32Bit]"
	<doNotGenerate>
	^(conditionBlockOrSymbolValue value
		ifNil: [false]
		ifNotNil: [:value|
			value isInteger
				ifTrue: [value ~= 0]
				ifFalse:
					[value isSymbol
						ifTrue: [(self class bindingOf: value)
									ifNil: [false]
									ifNotNil: [:binding| binding value]]
						ifFalse: [value]]])
		ifTrue: trueExpressionOrBlock
		ifFalse: falseExpressionOrBlockOrNil