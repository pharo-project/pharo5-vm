simulation only
debugStackPointerFor: bcpc
	<doNotGenerate>
	^(debugStackPointers at: bcpc) - (needsFrame ifTrue: [1] ifFalse: [0])