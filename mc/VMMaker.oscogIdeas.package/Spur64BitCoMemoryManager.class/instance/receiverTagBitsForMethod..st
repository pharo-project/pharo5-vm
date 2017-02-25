cog jit support
receiverTagBitsForMethod: aMethodObj
	"Answer the tag bits for the receiver based on the method's methodClass, if any."
	<api>
	| methodClass |
	methodClass := coInterpreter methodClassOf: aMethodObj.
	(self instSpecOfClass: methodClass) ~= self forwardedFormat ifTrue:
		[^0].
	methodClass = (self fetchPointer: self smallIntegerTag ofObject: classTableFirstPage) ifTrue:
		[^self smallIntegerTag].
	methodClass = (self fetchPointer: self characterTag ofObject: classTableFirstPage) ifTrue:
		[^self characterTag].
	self assert: methodClass = (self fetchPointer: self smallFloatTag ofObject: classTableFirstPage).
	^self smallFloatTag