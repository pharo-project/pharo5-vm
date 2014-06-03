class initialization
initialize
	"
	KlattSynthesizerPlugin initialize
	"
	| parameterClass |
	parameterClass := (Smalltalk hasClassNamed: #KlattFrame)
		ifTrue: [Smalltalk at: #KlattFrame "original package structure"]
		ifFalse: [Smalltalk at: #KlattResonatorIndices "repackaged to separate plugin from Speech dependency"].
	
	parameterClass parameterNames
		doWithIndex: [ :each :i | self classPool at: each capitalized asSymbol put: i-1].
	PI := Float pi	.
	Epsilon := 1.0e-04