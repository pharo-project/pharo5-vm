frame access
withoutSmallIntegerTags: anInteger
	<inline: true>
	<returnTypeC: #'char *'>
	self assert: (objectMemory isIntegerObject: anInteger).
	^self pointerForOop: (anInteger - 1)