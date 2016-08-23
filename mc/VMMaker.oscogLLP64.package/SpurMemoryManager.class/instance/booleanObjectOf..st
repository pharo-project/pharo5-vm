primitive support
booleanObjectOf: bool
	<inline: true>
	^bool ifTrue: [trueObj] ifFalse: [falseObj]