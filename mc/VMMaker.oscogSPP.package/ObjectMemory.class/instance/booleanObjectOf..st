interpreter access
booleanObjectOf: bool
	<inline: true>
	^bool ifTrue: [trueObj] ifFalse: [falseObj]