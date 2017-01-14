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
		fmt < objectMemory firstByteFormat ifTrue:  "64, 32, & 16 bits"
			[objectMemory hasSpurMemoryManagerAPI ifTrue:
				[fmt >= objectMemory firstShortFormat ifTrue:
					[valToPut := (objectMemory isIntegerObject: value)
									ifTrue: [objectMemory integerValueOf: value]
									ifFalse: [-1].
					(valToPut >= 0 and: [valToPut <= 65535]) ifFalse: [^self primitiveFailFor: PrimErrBadArgument].
					^objectMemory storeShort16: index - 1 ofObject: rcvr withValue: valToPut].
				 fmt = objectMemory sixtyFourBitIndexableFormat ifTrue:
					[| val64ToPut |
					 val64ToPut := self positive64BitValueOf: value.
					 self successful ifTrue:
						[^objectMemory storeLong64: index - 1 ofObject: rcvr withValue: val64ToPut].
					 ^self primitiveFailFor: PrimErrBadArgument]].
			 valToPut := self positive32BitValueOf: value.
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
				 objectMemory hasSpurMemoryManagerAPI ifTrue:
				 	[fmt < (objectMemory firstByteFormat + objectMemory firstStringyFakeFormat) ifTrue:
						[fmt < (objectMemory firstShortFormat + objectMemory firstStringyFakeFormat)
							ifTrue:
								[self assert: fmt ~= (objectMemory sixtyFourBitIndexableFormat + objectMemory firstStringyFakeFormat).
								 ^objectMemory storeLong32: index - 1 ofObject: rcvr withValue: valToPut]
							ifFalse:
								[(valToPut >= 0 and: [valToPut <= 65535]) ifFalse: [^self primitiveFailFor: PrimErrBadArgument].
								 ^objectMemory storeShort16: index - 1 ofObject: rcvr withValue: valToPut]]]]
			ifFalse:
				[(fmt >= objectMemory firstCompiledMethodFormat
				  and: [index < (self firstByteIndexOfMethod: rcvr)]) ifTrue:
					[^self primitiveFailFor: PrimErrBadIndex].
				valToPut := (objectMemory isIntegerObject: value)
								ifTrue: [objectMemory integerValueOf: value]
								ifFalse: [-1]].
		(valToPut >= 0 and: [valToPut <= 255]) ifFalse: [^self primitiveFailFor: PrimErrBadArgument].
		^objectMemory storeByte: index - 1 ofObject: rcvr withValue: valToPut].

	^self primitiveFailFor: ((objectMemory isIndexable: rcvr)
								ifFalse: [PrimErrBadReceiver]
								ifTrue: [PrimErrBadIndex])