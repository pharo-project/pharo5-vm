message sending
findNewMethodInClassTag: classTag
	"Find the compiled method to be run when the current 
	messageSelector is sent to the given class, setting the values 
	of 'newMethod' and 'primitiveIndex'."
	| ok class |
	<inline: false>
	ok := self lookupInMethodCacheSel: messageSelector classTag: classTag.
	ok ifFalse: "entry was not found in the cache; look it up the hard way "
		[(objectMemory isForwardedClassTag: lkupClassTag) ifTrue:
			[lkupClassTag := self handleForwardedSendFaultFor: lkupClassTag.
			ok := self lookupInMethodCacheSel: messageSelector classTag: lkupClassTag.
			ok ifTrue:
				[^nil]].
		 class := objectMemory classForClassTag: classTag.
		 self lookupMethodInClass: class.
		 self addNewMethodToCache: class]