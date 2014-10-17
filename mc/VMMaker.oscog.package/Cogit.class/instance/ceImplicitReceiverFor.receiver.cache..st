in-line cacheing
ceImplicitReceiverFor: selector receiver: receiver cache: cacheAddress
	"Cached implicit receiver implementation.  Caller looks like
				mov Lclass, Arg1Reg
				mov selector, SendNumArgsReg
				call ceImplicitReceiver
	 and Lclass: .word; Lmixin: .word is somewhere on the heap.
	 The trampoline has already fetched the class and probed the cache and found
	 that the cache missed.  Compute the implicit receiver for the receiver's class
	 and reload the class tag.  If either the class tag or the mixin are young then the
	 method needs to be added to the youngReferrers list to ensure correct GC."

	<option: #SpurMemoryManager>
	<var: #cacheAddress type: #usqInt>
	| rcvrClass mixin cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	mixin := coInterpreter
				implicitReceiverFor: receiver
				mixin: coInterpreter mMethodClass
				implementing: selector.
	rcvrClass := objectMemory fetchClassOf: receiver.
	cogMethod := coInterpreter mframeHomeMethodExport.
	cogMethod cmRefersToYoung ifFalse:
		[((objectRepresentation inlineCacheTagsMayBeObjects
		   and: [objectMemory isYoung: rcvrClass])
		  or: [mixin ~= receiver and: [objectMemory isYoung: mixin]]) ifTrue:
			[methodZone roomOnYoungReferrersList ifFalse:
				[coInterpreter callForCogCompiledCodeCompaction.
				 ^mixin].
			 cogMethod cmRefersToYoung: true.
			 methodZone addToYoungReferrers: cogMethod]].
	backEnd
		unalignedLongAt: cacheAddress
			put: (objectRepresentation inlineCacheTagForClass: rcvrClass);
		unalignedLongAt: cacheAddress + BytesPerOop
			put: (mixin = receiver ifTrue: [0] ifFalse: [mixin]).
	^mixin