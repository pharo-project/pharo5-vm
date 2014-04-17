indexing primitive support
commonVariable: rcvr at: index put: value cacheIndex: atIx
	"This code assumes the receiver has been identified at location atIx in the atCache."
	| stSize fmt fixedFields valToPut isCharacter |
	<inline: true>
	stSize := atCache at: atIx+AtCacheSize.
	((self oop: index isGreaterThanOrEqualTo: 1)
	  and: [self oop: index isLessThanOrEqualTo: stSize]) ifTrue:
		[fmt := atCache at: atIx+AtCacheFmt.
		fmt <= 4 ifTrue:
			[self assert: (objectMemory isContextNonInt: rcvr) not.
			 fixedFields := atCache at: atIx+AtCacheFixedFields.
			 ^objectMemory storePointer: index + fixedFields - 1 ofObject: rcvr withValue: value].
		fmt < 8 ifTrue:  "Bitmap"
			[valToPut := self positive32BitValueOf: value.
			self successful ifTrue: [objectMemory storeLong32: index - 1 ofObject: rcvr withValue: valToPut].
			^nil].
		fmt >= 16  "Note fmt >= 16 is an artificial flag for strings"
			ifTrue: [isCharacter := self isInstanceOfClassCharacter: value.
					isCharacter ifFalse:
						[^self primitiveFailFor: PrimErrBadArgument].
					valToPut := objectMemory fetchPointer: CharacterValueIndex ofObject: value]
			ifFalse:
				[(fmt >= 12 and: [index < (self firstByteIndexOfMethod: rcvr)]) ifTrue: "CompiledMethod"
					[^self primitiveFailFor: PrimErrBadIndex].
				valToPut := value].
		(objectMemory isIntegerObject: valToPut) ifTrue:
			[valToPut := objectMemory integerValueOf: valToPut.
			((valToPut >= 0) and: [valToPut <= 255]) ifFalse: [^self primitiveFailFor: PrimErrBadArgument].
			^objectMemory storeByte: index - 1 ofObject: rcvr withValue: valToPut]].

	^self primitiveFailFor: ((objectMemory formatOf: rcvr) <= 1
								ifTrue: [PrimErrBadReceiver]
								ifFalse: [PrimErrBadIndex])