cog jit support
lookup: selector receiver: rcvr
	<api>
	"Lookup selector in rcvr, without doing MNU processing, and answer either a
	 method or nil if the message was not understood.  Used to populate closed PICs."
	| class erridx |
	"self printFrame: stackPage headFP WithSP: stackPage headSP"
	"self printStringOf: selector"
	class := objectMemory fetchClassOf: rcvr.
	(self lookupInMethodCacheSel: selector class: class) ifFalse:
		[messageSelector := selector.
		 (erridx := self lookupMethodNoMNUEtcInClass: class) ~= 0 ifTrue:
			[^erridx]].
	^newMethod