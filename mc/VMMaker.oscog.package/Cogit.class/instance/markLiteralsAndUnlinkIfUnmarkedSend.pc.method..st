garbage collection
markLiteralsAndUnlinkIfUnmarkedSend: annotation pc: mcpc method: cogMethod
	"Mark and trace literals.  Unlink sends that have unmarked cache tags or targets."
	<var: #mcpc type: #'char *'>
	| literal |
	annotation = IsObjectReference ifTrue:
		[literal := backEnd literalBeforeFollowingAddress: mcpc asInteger.
		 objectRepresentation markAndTraceLiteral: literal].
	(self isSendAnnotation: annotation) ifTrue:
		[self offsetCacheTagAndCouldBeObjectAt: mcpc annotation: annotation into:
			[:entryPoint :cacheTag :tagCouldBeObj | | cacheTagMarked |
			 cacheTagMarked := tagCouldBeObj and: [objectRepresentation cacheTagIsMarked: cacheTag].
			 entryPoint > methodZoneBase
				ifTrue: "It's a linked send."
					[self targetMethodAndSendTableFor: entryPoint into:
						[:targetMethod :sendTable| | unlinkedRoutine |
						 (cacheTagMarked not
						  or: [self markAndTraceOrFreeCogMethod: targetMethod firstVisit: targetMethod asUnsignedInteger > mcpc asUnsignedInteger]) ifTrue:
							["Either the cacheTag is unmarked (e.g. new class) or the target
							  has been freed (because it is unmarked), so unlink the send."
							 unlinkedRoutine := sendTable at: (targetMethod cmNumArgs min: NumSendTrampolines - 1).
							 backEnd
								rewriteInlineCacheAt: mcpc asInteger
								tag: targetMethod selector
								target: unlinkedRoutine.
							 codeModified := true.
							 objectRepresentation markAndTraceLiteral: targetMethod selector]]]
				ifFalse:
					[objectRepresentation markAndTraceLiteral: cacheTag.  "cacheTag is selector"
					 self cppIf: NewspeakVM ifTrue:
						[entryPoint = ceImplicitReceiverTrampoline ifTrue:
							[| classpc mixinpc class mixin |
							 objectRepresentation markAndTraceLiteral: cacheTag.  "cacheTag is selector"
							 classpc := mcpc asInteger + backEnd jumpShortByteSize.
							 mixinpc := mcpc asInteger + backEnd jumpShortByteSize + BytesPerOop.
							 class := backEnd unalignedLongAt: classpc.
							 class ~= 0
								ifTrue:
									[self assert: (objectMemory addressCouldBeObj: class).
									 (objectRepresentation cacheTagIsMarked: class)
										ifTrue:
											[(mixin := backEnd unalignedLongAt: mixinpc) ~= 0 ifTrue:
												[objectRepresentation markAndTraceLiteral: mixin]]
										ifFalse:
											[backEnd
												unalignedLongAt: classpc put: 0;
												unalignedLongAt: mixinpc put: 0.
											 codeModified := true]]
								ifFalse:
									[self assert: (backEnd unalignedLongAt: mixinpc) = 0]]]]]].
	^0 "keep scanning"