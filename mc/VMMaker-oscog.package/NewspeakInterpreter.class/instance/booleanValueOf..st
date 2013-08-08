utilities
booleanValueOf: obj
"convert true and false (Smalltalk) to true or false(C)"
	obj = trueObj ifTrue: [ ^ true ].
	obj = falseObj ifTrue: [ ^ false ].
	^self primitiveFail