indexing primitive support
commonVariable: rcvr at: index put: value cacheIndex: atIx
	"This code assumes the receiver has been identified at location atIx in the atCache."
	| stSize fmt fixedFields valToPut isCharacter |
	<inline: true>
	stSize := atCache at: atIx+AtCacheSize.
	((self oop: index isGreaterThanOrEqualTo: 1)
	  and: [self oop: index isLessThanOrEqualTo: stSize]) ifTrue:
		[fmt := atCache at: atIx+AtCacheFmt.
		fmt <= objectMemory weakArrayFormat ifTrue:
			[self assert: (objectMemory isContextNonImm: rcvr) not.
			 fixedFields := atCache at: atIx+AtCacheFixedFields.
			 ^objectMemory storePointer: index + fixedFields - 1 ofObject: rcvr withValue: value].
		fmt < objectMemory firstByteFormat ifTrue:  "Bitmap"
			[valToPut := self positive32BitValueOf: value.
			 self successful ifTrue:
				[^objectMemory storeLong32: index - 1 ofObject: rcvr withValue: valToPut].
			 ^self primitiveFailFor: PrimErrBadArgument].
		fmt >= objectMemory firstStringyFakeFormat  "Note fmt >= firstStringyFormat is an artificial flag for strings"
			ifTrue:
				[isCharacter := objectMemory isCharacterObject: value.
				 isCharacter ifFalse:
					[^self primitiveFailFor: PrimErrBadArgument].
				 objectMemory hasSpurMemoryManagerAPI
					ifTrue: [valToPut := objectMemory characterValueOf: value]
					ifFalse:
						[valToPut := objectMemory fetchPointer: CharacterValueIndex ofObject: value.
						 valToPut := (objectMemory isIntegerObject: valToPut)
										ifTrue: [objectMemory integerValueOf: valToPut]
										ifFalse: [-1]].
				 (objectMemory hasSpurMemoryManagerAPI
				  and: [fmt - objectMemory firstStringyFakeFormat < objectMemory firstByteFormat]) ifTrue:
					[^objectMemory storeLong32: index - 1 ofObject: rcvr withValue: valToPut]]
			ifFalse:
				[(fmt >= objectMemory firstCompiledMethodFormat
				  and: [index < (self firstByteIndexOfMethod: rcvr)]) ifTrue:
					[^self primitiveFailFor: PrimErrBadIndex].
				valToPut := (objectMemory isIntegerObject: value)
								ifTrue: [objectMemory integerValueOf: value]
								ifFalse: [-1]].
		((valToPut >= 0) and: [valToPut <= 255]) ifFalse: [^self primitiveFailFor: PrimErrBadArgument].
		^objectMemory storeByte: index - 1 ofObject: rcvr withValue: valToPut].

	^self primitiveFailFor: ((objectMemory isIndexable: rcvr)
								ifFalse: [PrimErrBadReceiver]
								ifTrue: [PrimErrBadIndex])