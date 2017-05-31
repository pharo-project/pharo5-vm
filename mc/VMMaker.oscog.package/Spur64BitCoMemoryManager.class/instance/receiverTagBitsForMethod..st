cog jit support
receiverTagBitsForMethod: aMethodObj
	"Answer the tag bits for the receiver based on the method's methodClass, if any."
	<api>
	| methodClassOrNil |
	methodClassOrNil := coInterpreter methodClassOf: aMethodObj.
	NewspeakVM "Mixins don't necessarily have a format inst var; filter out non-integer format."
		ifTrue:
			[| instSpec |
			(methodClassOrNil = nilObj
			 or: [(self isNonIntegerObject: (instSpec := self fetchPointer: InstanceSpecificationIndex ofObject: methodClassOrNil))
			 or: [(self self instSpecOfClassFormat: (self integerValueOf: instSpec)) ~= self forwardedFormat]]) ifTrue:
				[^0]]
		ifFalse:
			[(methodClassOrNil = nilObj
			 or: [(self instSpecOfClass: methodClassOrNil) ~= self forwardedFormat]) ifTrue:
				[^0]].
	methodClassOrNil = (self fetchPointer: self smallIntegerTag ofObject: classTableFirstPage) ifTrue:
		[^self smallIntegerTag].
	methodClassOrNil = (self fetchPointer: self characterTag ofObject: classTableFirstPage) ifTrue:
		[^self characterTag].
	self assert: methodClassOrNil = (self fetchPointer: self smallFloatTag ofObject: classTableFirstPage).
	^self smallFloatTag