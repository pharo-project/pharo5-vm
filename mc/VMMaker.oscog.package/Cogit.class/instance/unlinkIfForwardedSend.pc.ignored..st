in-line cacheing
unlinkIfForwardedSend: annotation pc: mcpc ignored: superfluity
	<var: #mcpc type: #'char *'>
	| entryPoint cacheAddress |
	(self isSendAnnotation: annotation) ifTrue:
		[entryPoint := backEnd callTargetFromReturnAddress: mcpc asInteger.
		 entryPoint > methodZoneBase
			ifTrue: "It's a linked send, but maybe a super send or linked to an OpenPIC, in which case the cache tag will be a selector...."
				[(objectMemory isForwardedClassIndex: (backEnd inlineCacheTagAt: mcpc)) ifTrue:
					[self targetMethodAndSendTableFor: entryPoint into:
						[:targetMethod :sendTable|
						 self unlinkSendAt: mcpc targetMethod: targetMethod sendTable: sendTable]]]
			ifFalse:
				[self cppIf: NewspeakVM ifTrue:
					[entryPoint = ceImplicitReceiverTrampoline ifTrue:
						[self assert: NumOopsPerIRC = 2.
						 cacheAddress := self implicitReceiverCacheAddressAt: mcpc.
						 ((objectMemory isForwardedClassIndex: (backEnd unalignedLongAt: cacheAddress))
						 or: [objectMemory isForwardedClassIndex: (backEnd unalignedLongAt: cacheAddress + BytesPerOop)]) ifTrue:
							[self voidImplicitReceiverCacheAt: mcpc]]]]].
	^0 "keep scanning"