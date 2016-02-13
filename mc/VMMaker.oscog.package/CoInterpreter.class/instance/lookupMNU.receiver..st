cog jit support
lookupMNU: selector receiver: rcvr
	<api>
	"Lookup selector in rcvr, without doing MNU processing, and answer either a
	 method or an error code if the message was not understood.  Used to populate closed PICs."
	| classTag inCache erridx |
	"self printFrame: stackPage headFP WithSP: stackPage headSP"
	"self printStringOf: selector"
	classTag := objectMemory fetchClassTagOf: rcvr.
	NewspeakVM
	  	ifTrue:
			[inCache := self
							inlineLookupInNSMethodCacheSel: selector
							classTag: classTag
							method: 0
							lookupRule: LookupRuleMNU]
		ifFalse:
			[inCache := self lookupInMethodCacheSel: selector classTag: classTag].
	inCache ifFalse:
		[messageSelector := selector.
		 erridx := self lookupMNUInClass: (objectMemory classForClassTag: classTag).
		 erridx ~= 0 ifTrue:
			[self assert: erridx <= self maxLookupNoMNUErrorCode.
			 ^erridx]].
	^newMethod