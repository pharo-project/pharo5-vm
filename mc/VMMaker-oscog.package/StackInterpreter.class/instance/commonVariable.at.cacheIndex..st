indexing primitive support
commonVariable: rcvr at: index cacheIndex: atIx 
	"This code assumes the receiver has been identified at location atIx in the atCache."
	| stSize fmt fixedFields result |
	<inline: true>
	stSize := atCache at: atIx+AtCacheSize.
	((self oop: index isGreaterThanOrEqualTo: 1)
	 and: [self oop: index isLessThanOrEqualTo: stSize]) ifTrue:
		[fmt := atCache at: atIx+AtCacheFmt.
		 fmt <= 4 ifTrue:
			[self assert: (objectMemory isContextNonInt: rcvr) not.
			 fixedFields := atCache at: atIx+AtCacheFixedFields.
			 ^objectMemory fetchPointer: index + fixedFields - 1 ofObject: rcvr].
		 fmt < 8 ifTrue:  "Bitmap"
			[result := objectMemory fetchLong32: index - 1 ofObject: rcvr.
			 ^self positive32BitIntegerFor: result].
		 fmt >= 16  "Note fmt >= 16 is an artificial flag for strings"
			ifTrue: "String"
				[^self characterForAscii: (objectMemory fetchByte: index - 1 ofObject: rcvr)]
			ifFalse:
				[(fmt < 12 "ByteArray"
				  or: [index >= (self firstByteIndexOfMethod: rcvr) "CompiledMethod"]) ifTrue:
					[^objectMemory integerObjectOf: (objectMemory fetchByte: index - 1 ofObject: rcvr)]]].

	^self primitiveFailFor: ((objectMemory formatOf: rcvr) <= 1
								ifTrue: [PrimErrBadReceiver]
								ifFalse: [PrimErrBadIndex])