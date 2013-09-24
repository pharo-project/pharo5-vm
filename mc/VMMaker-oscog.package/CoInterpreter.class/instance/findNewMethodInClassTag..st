message sending
findNewMethodInClassTag: classTag
	"Find the compiled method to be run when the current messageSelector is
	 sent to the given classTag, setting the values of newMethod and primitiveIndex."
	| ok class |
	<inline: false>
	ok := self lookupInMethodCacheSel: messageSelector classTag: classTag.
	ok	ifTrue:
			[self ifAppropriateCompileToNativeCode: newMethod selector: messageSelector]
		ifFalse:
			["entry was not found in the cache; look it up the hard way "
			 class := objectMemory classForClassTag: classTag.
			 objectMemory hasSpurMemoryManagerAPI ifTrue:
			 	[| oop |
				 oop := self stackValue: argumentCount.
				 ((objectMemory isNonImmediate: oop)
				  and: [objectMemory isForwarded: oop]) ifTrue:
					[self stackValue: argumentCount put: (objectMemory followForwarded: oop)]].
			 self lookupMethodInClass: class.
			 self addNewMethodToCache: class]