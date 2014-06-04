object testing
isWeakNonImm: objOop
	<inline: true>
	^self isWeakFormat: (self formatOf: objOop)