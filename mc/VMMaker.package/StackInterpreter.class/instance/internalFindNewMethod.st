message sending
internalFindNewMethod
	"Find the compiled method to be run when the current messageSelector is sent to the class 'lkupClass', setting the values of 'newMethod' and 'primitiveIndex'."
	| ok | 
	<inline: true>
	ok := self lookupInMethodCacheSel: messageSelector classTag: lkupClassTag.
	ok ifFalse: "entry was not found in the cache; look it up the hard way"
		[self externalizeIPandSP.
		 ((objectMemory isOopForwarded: messageSelector)
		  or: [objectMemory isForwardedClassTag: lkupClassTag]) ifTrue:
			[(objectMemory isOopForwarded: messageSelector) ifTrue:
				[messageSelector := self handleForwardedSelectorFaultFor: messageSelector].
			 (objectMemory isForwardedClassTag: lkupClassTag) ifTrue:
				[lkupClassTag := self handleForwardedSendFaultForTag: lkupClassTag].
			ok := self lookupInMethodCacheSel: messageSelector classTag: lkupClassTag.
			ok ifTrue:
				[^nil]].
		 lkupClass := objectMemory classForClassTag: lkupClassTag.
		 self lookupMethodInClass: lkupClass.
		 self internalizeIPandSP.
		 self addNewMethodToCache: lkupClass]