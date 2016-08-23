message sending
internalFindNewMethodOrdinary
	"Find the compiled method to be run when the current messageSelector is sent to the class 'lkupClass', setting the values of 'newMethod' and 'primitiveIndex'."
	<inline: true>
	(self inlineLookupInMethodCacheSel: messageSelector classTag: lkupClassTag) ifFalse:
		["entry was not found in the cache; look it up the hard way"
		 self externalizeIPandSP.
		 ((objectMemory isOopForwarded: messageSelector)
		  or: [objectMemory isForwardedClassTag: lkupClassTag]) ifTrue:
			[(objectMemory isOopForwarded: messageSelector) ifTrue:
				[messageSelector := self handleForwardedSelectorFaultFor: messageSelector].
			 (objectMemory isForwardedClassTag: lkupClassTag) ifTrue:
				[lkupClassTag := self handleForwardedSendFaultForTag: lkupClassTag].
			(self lookupInMethodCacheSel: messageSelector classTag: lkupClassTag) ifTrue:
				[^nil]].
		 lkupClass := objectMemory classForClassTag: lkupClassTag.
		 NewspeakVM
			ifTrue: [self lookupOrdinarySend]
			ifFalse: [self lookupMethodInClass: lkupClass].
		 self internalizeIPandSP.
		 self addNewMethodToCache: lkupClass].
