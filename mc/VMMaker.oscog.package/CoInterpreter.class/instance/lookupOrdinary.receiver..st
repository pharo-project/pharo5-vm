cog jit support
lookupOrdinary: selector receiver: rcvr
	<api>
	"Lookup selector in rcvr, without doing MNU processing, and answer either a
	 method or an error code if the message was not understood.  Used to populate closed PICs."
	| classTag erridx |
	"self printFrame: stackPage headFP WithSP: stackPage headSP"
	"self printStringOf: selector"
	classTag := objectMemory fetchClassTagOf: rcvr.
	(self lookupInMethodCacheSel: selector classTag: classTag) ifFalse:
		[messageSelector := selector.
		 (erridx := self lookupOrdinaryNoMNUEtcInClass: (objectMemory classForClassTag: classTag)) ~= 0 ifTrue:
			[self assert: erridx <= self maxLookupNoMNUErrorCode.
			 ^erridx]].
	^newMethod