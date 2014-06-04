in-line cacheing
ceImplicitReceiverFor: selector receiver: receiver class: rcvrClass
	"Cached implicit receiver implementation.  Caller looks like
		mov selector, ClassReg
				call ceImplicitReceiver
				br continue
		Lclass	.word
		Lmixin:	.word
		continue:
	 The trampoline has already fetched the class and probed the cache and found
	 that the cache missed.  Compute the implicit receiver for the receiver's class
	 and reload the class.  If either the class or the mixin are young the method needs
	 to be added to the youngReferrers list to ensure correct GC."

	| retpc classpc mixinpc mixin cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	retpc := coInterpreter stackTop.
	classpc := retpc + backEnd jumpShortByteSize.
	mixinpc := retpc + backEnd jumpShortByteSize + BytesPerOop.
	self assert: rcvrClass ~= (backEnd unalignedLongAt: classpc).
	mixin := coInterpreter
				implicitReceiverFor: receiver
				mixin: coInterpreter mMethodClass
				implementing: selector.
	cogMethod := coInterpreter mframeHomeMethodExport.
	cogMethod cmRefersToYoung ifFalse:
		[((objectMemory isYoung: rcvrClass)
		  or: [mixin ~= receiver and: [objectMemory isYoung: mixin]]) ifTrue:
			[methodZone roomOnYoungReferrersList ifFalse:
				[coInterpreter callForCogCompiledCodeCompaction.
				 ^mixin].
			 cogMethod cmRefersToYoung: true.
			 methodZone addToYoungReferrers: cogMethod]].
	backEnd unalignedLongAt: classpc put: rcvrClass.
	backEnd unalignedLongAt: mixinpc put: (mixin = receiver ifTrue: [0] ifFalse: [mixin]).
	^mixin