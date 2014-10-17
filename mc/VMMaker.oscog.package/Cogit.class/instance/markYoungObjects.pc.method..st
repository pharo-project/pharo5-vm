garbage collection
markYoungObjects: annotation pc: mcpc method: cogMethod
	"Mark and trace young literals."
	<var: #mcpc type: #'char *'>
	| literal |
	annotation = IsObjectReference ifTrue:
		[literal := backEnd literalBeforeFollowingAddress: mcpc asInteger.
		 objectRepresentation markAndTraceLiteralIfYoung: literal].
	(self isSendAnnotation: annotation) ifTrue:
		[self offsetCacheTagAndCouldBeObjectAt: mcpc annotation: annotation into:
			[:entryPoint :cacheTag :tagCouldBeObj |
			 tagCouldBeObj ifTrue:
				[objectRepresentation markAndTraceLiteralIfYoung: cacheTag].
				 self cppIf: NewspeakVM ifTrue:
					[entryPoint = ceImplicitReceiverTrampoline ifTrue:
						[| cacheAddress class mixin |
						 self assert: NumOopsPerIRC = 2.
						 cacheAddress := self implicitReceiverCacheAddressAt: mcpc.
						 class := backEnd unalignedLongAt: cacheAddress.
						 class ~= 0 ifTrue:
							[objectRepresentation inlineCacheTagsMayBeObjects ifTrue:
								[objectRepresentation markAndTraceLiteralIfYoung: class].
							 mixin := backEnd unalignedLongAt: cacheAddress + BytesPerOop.
							 objectRepresentation markAndTraceLiteralIfYoung: mixin]]]]].
	^0 "keep scanning"