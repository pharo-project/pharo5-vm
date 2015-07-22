message sending
internalFindNewMethodOrdinary
	"Find the compiled method to be run when the current messageSelector is
	 sent to the given class, setting the values of newMethod and primitiveIndex."
	| ok |
	<inline: true>
	ok := self inlineLookupInMethodCacheSel: messageSelector classTag: lkupClassTag.
	ok	ifTrue:
			[self ifAppropriateCompileToNativeCode: newMethod selector: messageSelector]
		ifFalse:
			[self externalizeIPandSP.
			 ((objectMemory isOopForwarded: messageSelector)
			  or: [objectMemory isForwardedClassTag: lkupClassTag]) ifTrue:
				[(objectMemory isOopForwarded: messageSelector) ifTrue:
					[messageSelector := self handleForwardedSelectorFaultFor: messageSelector].
				 (objectMemory isForwardedClassTag: lkupClassTag) ifTrue:
					[lkupClassTag := self handleForwardedSendFaultForTag: lkupClassTag].
				(self lookupInMethodCacheSel: messageSelector classTag: lkupClassTag) ifTrue:
					[^self ifAppropriateCompileToNativeCode: newMethod selector: messageSelector]].
			lkupClass := objectMemory classForClassTag: lkupClassTag.
			NewspeakVM
				ifTrue: [self lookupOrdinarySend]
				ifFalse: [self lookupMethodInClass: lkupClass].
			self internalizeIPandSP.
			self addNewMethodToCache: lkupClass]