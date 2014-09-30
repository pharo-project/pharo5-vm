garbage collection
markLiteralsAndUnlinkIfUnmarkedSend: annotation pc: mcpc method: cogMethod
	"Mark and trace literals.  Unlink sends that have unmarked cache tags or targets."
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
			[:entryPoint :cacheTag :tagCouldBeObj | | cacheTagMarked |
			 cacheTagMarked := tagCouldBeObj and: [objectRepresentation cacheTagIsMarked: cacheTag].
			 entryPoint > methodZoneBase
				ifTrue: "It's a linked send."
					[self targetMethodAndSendTableFor: entryPoint into:
						[:targetMethod :sendTable| 
						 (cacheTagMarked not
						  or: [self markAndTraceOrFreeCogMethod: targetMethod
								firstVisit: targetMethod asUnsignedInteger > mcpc asUnsignedInteger]) ifTrue:
							["Either the cacheTag is unmarked (e.g. new class) or the target
							  has been freed (because it is unmarked), so unlink the send."
							 self unlinkSendAt: mcpc targetMethod: targetMethod sendTable: sendTable.
							 objectRepresentation
								markAndTraceLiteral: targetMethod selector
								in: targetMethod
								at: (self addressOf: targetMethod selector put: [:val| targetMethod selector: val])]]]
				ifFalse:  "cacheTag is selector"
					[(objectRepresentation
							markAndTraceCacheTagLiteral: cacheTag
							in: cogMethod
							atpc: mcpc asUnsignedInteger) ifTrue:
						[codeModified := true].
					 self cppIf: NewspeakVM ifTrue:
						[entryPoint = ceImplicitReceiverTrampoline ifTrue:
							[| cacheAddress class mixin |
							 (objectRepresentation
									markAndTraceCacheTagLiteral: cacheTag
									in: cogMethod
									atpc: mcpc asUnsignedInteger) ifTrue:
								[codeModified := true].  "cacheTag is selector"
							 self assert: NumOopsPerIRC = 2.
							 cacheAddress := self implicitReceiverCacheAddressAt: mcpc.
							 (class := backEnd unalignedLongAt: cacheAddress) ~= 0
								ifTrue:
									[(objectRepresentation cacheTagIsMarked: class)
										ifTrue:
											[(mixin := backEnd unalignedLongAt: cacheAddress + BytesPerOop) ~= 0 ifTrue:
												[objectRepresentation
													markAndTraceLiteral: mixin
													in: (self cCoerceSimple: cogMethod to: #'CogMethod *')
													at: (self asAddress: cacheAddress + BytesPerOop
															put: [:val| backEnd unalignedLongAt: cacheAddress + BytesPerOop put: val])]]
										ifFalse:
											[backEnd
												unalignedLongAt: cacheAddress put: 0;
												unalignedLongAt: cacheAddress + BytesPerOop put: 0.
											 codeModified := true]]
								ifFalse:
									[self assert: (backEnd unalignedLongAt: cacheAddress + BytesPerOop) = 0]]]]]].
	^0 "keep scanning"