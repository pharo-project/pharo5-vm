garbage collection
markLiterals: annotation pc: mcpc method: cogMethod
	"Mark and trace literals.
	 Additionally in Newspeak, void push implicits that have unmarked classes."
	<var: #mcpc type: #'char *'>
	| literal |
	annotation = IsObjectReference ifTrue:
		[literal := backEnd literalBeforeFollowingAddress: mcpc asUnsignedInteger.
		 (objectRepresentation
				markAndTraceLiteral: literal
				in: (self cCoerceSimple: cogMethod to: #'CogMethod *')
				atpc: mcpc asUnsignedInteger) ifTrue:
			[codeModified := true]].
	(self isSendAnnotation: annotation) ifTrue:
		[self offsetCacheTagAndCouldBeObjectAt: mcpc annotation: annotation into:
			[:entryPoint :cacheTag :tagCouldBeObj |
			 tagCouldBeObj ifTrue:
				[(objectRepresentation
						markAndTraceCacheTagLiteral: cacheTag
						in: (self cCoerceSimple: cogMethod to: #'CogMethod *')
						atpc: mcpc asUnsignedInteger) ifTrue:
					[codeModified := true]].  "cacheTag is selector"
			  self cppIf: NewspeakVM ifTrue:
				[entryPoint = ceImplicitReceiverTrampoline ifTrue:
					[| cacheAddress class mixin |
					 self assert: NumOopsPerIRC = 2.
					 cacheAddress := self implicitReceiverCacheAddressAt: mcpc.
					 (class := backEnd unalignedLongAt: cacheAddress) ~= 0
						ifTrue:
							[(objectRepresentation cacheTagIsMarked: class)
								ifTrue:
									[(mixin := backEnd unalignedLongAt: cacheAddress + objectMemory bytesPerOop) ~= 0 ifTrue:
										[objectRepresentation
											markAndTraceLiteral: mixin
											in: (self cCoerceSimple: cogMethod to: #'CogMethod *')
											at: (self asAddress: cacheAddress + objectMemory bytesPerOop
													put: [:val| backEnd unalignedLongAt: cacheAddress + objectMemory bytesPerOop put: val])]]
								ifFalse:
									[backEnd
										unalignedLongAt: cacheAddress put: 0;
										unalignedLongAt: cacheAddress + objectMemory bytesPerOop put: 0.
									 codeModified := true]]
						ifFalse:
							[self assert: (backEnd unalignedLongAt: cacheAddress + objectMemory bytesPerOop) = 0]]]]].
	^0 "keep scanning"