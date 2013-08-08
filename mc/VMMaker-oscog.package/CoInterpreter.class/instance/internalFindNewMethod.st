message sending
internalFindNewMethod
	"Find the compiled method to be run when the current messageSelector is
	 sent to the given class, setting the values of newMethod and primitiveIndex."
	| ok |
	<inline: true>
	ok := self lookupInMethodCacheSel: messageSelector class: lkupClass.
	ok	ifTrue:
			[self ifAppropriateCompileToNativeCode: newMethod selector: messageSelector]
		ifFalse:
			["entry was not found in the cache; look it up the hard way"
			self externalizeIPandSP.
			self lookupMethodInClass: lkupClass.
			self internalizeIPandSP.
			self addNewMethodToCache: lkupClass]