indexing primitive support
commonVariable: rcvr at: index cacheIndex: atIx 
	"This code assumes the receiver has been identified at location atIx in the atCache."
	| stSize fmt fixedFields result |
	<inline: true>
	stSize := atCache at: atIx+AtCacheSize.
	((self oop: index isGreaterThanOrEqualTo: 1)
	 and: [self oop: index isLessThanOrEqualTo: stSize]) ifTrue:
		[fmt := atCache at: atIx+AtCacheFmt.
		 fmt <= objectMemory weakArrayFormat ifTrue:
			[self assert: (objectMemory isContextNonImm: rcvr) not.
			 fixedFields := atCache at: atIx+AtCacheFixedFields.
			 ^objectMemory fetchPointer: index + fixedFields - 1 ofObject: rcvr].
		 fmt < objectMemory firstByteFormat ifTrue: "64, 32, & 16 bits"
			[objectMemory hasSpurMemoryManagerAPI ifTrue:
				[fmt >= objectMemory firstShortFormat ifTrue:
					[^objectMemory integerObjectOf:
						(objectMemory fetchUnsignedShort16: index - 1 ofObject: rcvr)].
				 fmt = objectMemory sixtyFourBitIndexableFormat ifTrue:
					[^self positive64BitIntegerFor:
						(objectMemory fetchLong64: index - 1 ofObject: rcvr)]].
			 result := objectMemory fetchLong32: index - 1 ofObject: rcvr.
			 ^self positive32BitIntegerFor: result].
		 fmt >= objectMemory firstStringyFakeFormat  "Note fmt >= firstStringyFormat is an artificial flag for strings"
			ifTrue: "String"
				["Spur supports the String at:[put:] primitives on WideString and DoubleByteString"
				 result := (objectMemory hasSpurMemoryManagerAPI
							and: [fmt < (objectMemory firstByteFormat + objectMemory firstStringyFakeFormat)])
								ifTrue:
									[fmt < (objectMemory firstShortFormat + objectMemory firstStringyFakeFormat)
										ifTrue: [objectMemory fetchLong32: index - 1 ofObject: rcvr]
										ifFalse: [objectMemory fetchUnsignedShort16: index - 1 ofObject: rcvr]]
								ifFalse: [objectMemory fetchByte: index - 1 ofObject: rcvr].
				^self characterForAscii: result]
			ifFalse:
				[(fmt < objectMemory firstCompiledMethodFormat "ByteArray"
				  or: [index >= (self firstByteIndexOfMethod: rcvr) "CompiledMethod"]) ifTrue:
					[^objectMemory integerObjectOf: (objectMemory fetchByte: index - 1 ofObject: rcvr)]]].

	^self primitiveFailFor: ((objectMemory isIndexable: rcvr)
								ifFalse: [PrimErrBadReceiver]
								ifTrue: [PrimErrBadIndex])