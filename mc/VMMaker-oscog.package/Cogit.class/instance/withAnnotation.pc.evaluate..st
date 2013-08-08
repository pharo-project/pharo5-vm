garbage collection
withAnnotation: annotation pc: mcpc evaluate: aBinaryBlock
	<doNotGenerate>
	^(aBinaryBlock value: annotation value: mcpc) ifTrue: [1] ifFalse: [0]