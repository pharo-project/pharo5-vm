garbage collection
markLiterals: annotation pc: mcpc method: cogMethod
	"Mark and trace literals.
	 Additionally in Newspeak, void push implicits that have unmarked classes."
	<var: #mcpc type: #'char *'>
	| literal |
	annotation = IsObjectReference ifTrue:
		[literal := backEnd literalBeforeFollowingAddress: mcpc asInteger.
		 objectRepresentation markAndTraceLiteral: literal].
	(self isSendAnnotation: annotation) ifTrue:
		[self offsetCacheTagAndCouldBeObjectAt: mcpc annotation: annotation into:
			[:entryPoint :cacheTag :tagCouldBeObj |
			 tagCouldBeObj ifTrue:
				[objectRepresentation markAndTraceLiteral: cacheTag].  "cacheTag is selector"
			  self cppIf: NewspeakVM ifTrue:
				[entryPoint = ceImplicitReceiverTrampoline ifTrue:
					[| classpc mixinpc class mixin |
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
							[self assert: (backEnd unalignedLongAt: mixinpc) = 0]]]]].
	^0 "keep scanning"