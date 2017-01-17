message sending
findNewMethodInClassTag: classTagArg
	"Find the compiled method to be run when the current 
	messageSelector is sent to the given class, setting the values 
	of 'newMethod' and 'primitiveIndex'."
	| ok classTag |
	<inline: false>
	ok := self lookupInMethodCacheSel: messageSelector classTag: classTagArg.
	ok ifFalse: "entry was not found in the cache; look it up the hard way "
		[classTag := classTagArg.
		 ((objectMemory isOopForwarded: messageSelector)
		  or: [objectMemory isForwardedClassTag: classTag]) ifTrue:
			[(objectMemory isOopForwarded: messageSelector) ifTrue:
				[messageSelector := self handleForwardedSelectorFaultFor: messageSelector].
			 (objectMemory isForwardedClassTag: classTag) ifTrue:
				[classTag := self handleForwardedSendFaultForTag: classTag].
			ok := self lookupInMethodCacheSel: messageSelector classTag: classTag.
			ok ifTrue:
				[^nil]].
 		 lkupClass := objectMemory classForClassTag: classTag.
		 NewspeakVM
				ifTrue: [self lookupOrdinarySend]
				ifFalse: [self lookupMethodInClass: lkupClass].
		 self addNewMethodToCache: lkupClass]