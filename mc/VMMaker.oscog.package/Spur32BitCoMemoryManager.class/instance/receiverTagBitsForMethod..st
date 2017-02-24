cog jit support
receiverTagBitsForMethod: aMethodObj
	"Answer the tag bits for the receiver based on the method's methodClass, if any."
	<api>
	| methodClass |
	methodClass := coInterpreter methodClassOf: aMethodObj.
	(self instSpecOfClass: methodClass) ~= self forwardedFormat ifTrue:
		[^0].
	^methodClass = (self fetchPointer: self smallIntegerTag ofObject: classTableFirstPage)
		ifTrue: [self smallIntegerTag]
		ifFalse: [self assert: methodClass = (self fetchPointer: self characterTag ofObject: classTableFirstPage).
				self characterTag]