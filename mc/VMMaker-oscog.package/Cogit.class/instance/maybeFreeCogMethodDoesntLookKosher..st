debugging
maybeFreeCogMethodDoesntLookKosher: cogMethod
	"Check that the header fields are consistent with the type.
	 Answer 0 if it is ok, otherwise answer a code for the error."
	<var: #cogMethod type: #'CogMethod *'>
	| result |
	result := self cogMethodDoesntLookKosher: cogMethod.
	^result = 2 ifTrue: [0] ifFalse: [result]