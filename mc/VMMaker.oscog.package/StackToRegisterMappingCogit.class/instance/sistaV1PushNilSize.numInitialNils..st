span functions
sistaV1PushNilSize: aMethodObj numInitialNils: numInitialNils
	"230		11100110	iiiiiiii		PushNClosureTemps iiiiiiii"
	<inline: true>
	^numInitialNils = 0 ifTrue: [0] ifFalse: [2]