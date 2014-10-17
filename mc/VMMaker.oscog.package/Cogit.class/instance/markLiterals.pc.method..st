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
					[| cacheAddress class mixin |
					 self assert: NumOopsPerIRC = 2.
					 cacheAddress := self implicitReceiverCacheAddressAt: mcpc.
					 class := backEnd unalignedLongAt: cacheAddress.
					 class ~= 0
						ifTrue:
							[(objectRepresentation cacheTagIsMarked: class)
								ifTrue:
									[(mixin := backEnd unalignedLongAt: cacheAddress + BytesPerOop) ~= 0 ifTrue:
										[objectRepresentation markAndTraceLiteral: mixin]]
								ifFalse:
									[backEnd
										unalignedLongAt: cacheAddress put: 0;
										unalignedLongAt: cacheAddress + BytesPerOop put: 0.
									 codeModified := true]]
						ifFalse:
							[self assert: (backEnd unalignedLongAt: cacheAddress + BytesPerOop) = 0]]]]].
	^0 "keep scanning"