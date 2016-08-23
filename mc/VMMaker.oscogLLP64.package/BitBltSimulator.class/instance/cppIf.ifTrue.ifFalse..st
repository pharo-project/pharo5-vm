translation support
cppIf: conditionBlockOrSymbolValue ifTrue: trueExpressionOrBlock ifFalse: falseExpressionOrBlockOrNil
	"The simulator does not have fast blt defines"
	^ conditionBlockOrSymbolValue = #'ENABLE_FAST_BLT'
		ifTrue: falseExpressionOrBlockOrNil
		ifFalse: [super
					cppIf: conditionBlockOrSymbolValue
					ifTrue: trueExpressionOrBlock
					ifFalse: falseExpressionOrBlockOrNil]