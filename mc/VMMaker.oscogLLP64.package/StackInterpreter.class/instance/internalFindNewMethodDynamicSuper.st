message sending
internalFindNewMethodDynamicSuper
	"Find the compiled method to be run when the current messageSelector is sent to the superclass of the class where the current method was looked up, setting the values of 'newMethod' and 'primitiveIndex'."
	<inline: true>
	localAbsentReceiver := self receiver.
	self deny: (objectMemory isOopForwarded: localAbsentReceiver).
	lkupClassTag := objectMemory fetchClassTagOf: localAbsentReceiver.

	(self inlineLookupInNSMethodCacheSel: messageSelector classTag: lkupClassTag method: method lookupRule: LookupRuleDynamicSuper)
	 ifFalse:
		[ | actualLookupRule |
		"entry was not found in the cache; look it up the hard way"
		 self externalizeIPandSP.
		 ((objectMemory isOopForwarded: messageSelector)
		  or: [objectMemory isForwardedClassTag: lkupClassTag]) ifTrue:
			[(objectMemory isOopForwarded: messageSelector) ifTrue:
				[messageSelector := self handleForwardedSelectorFaultFor: messageSelector].
			 (objectMemory isForwardedClassTag: lkupClassTag) ifTrue:
				[lkupClassTag := self handleForwardedSendFaultForTag: lkupClassTag].
			"(self lookupInMethodCacheSel: messageSelector classTag: lkupClassTag) ifTrue:
				[^nil]"].
		 lkupClass := objectMemory classForClassTag: lkupClassTag.
		 actualLookupRule := self lookupDynamicSuperSend.
		 self internalizeIPandSP.
		 self addNewMethodToNSCache: actualLookupRule].
