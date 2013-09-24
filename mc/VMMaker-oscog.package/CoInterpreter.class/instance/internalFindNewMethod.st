message sending
internalFindNewMethod
	"Find the compiled method to be run when the current messageSelector is
	 sent to the given class, setting the values of newMethod and primitiveIndex."
	| ok |
	<inline: true>
	ok := self lookupInMethodCacheSel: messageSelector classTag: lkupClassTag.
	ok	ifTrue:
			[self ifAppropriateCompileToNativeCode: newMethod selector: messageSelector]
		ifFalse:
			["entry was not found in the cache; look it up the hard way"
			lkupClass := objectMemory classForClassTag: lkupClassTag.
			objectMemory hasSpurMemoryManagerAPI ifTrue:
				[| oop |
				 oop := self internalStackValue: argumentCount.
				 ((objectMemory isNonImmediate: oop)
				  and: [objectMemory isForwarded: oop]) ifTrue:
					[self internalStackValue: argumentCount put: (objectMemory followForwarded: oop)]].
			self externalizeIPandSP.
			self lookupMethodInClass: lkupClass.
			self internalizeIPandSP.
			self addNewMethodToCache: lkupClass]