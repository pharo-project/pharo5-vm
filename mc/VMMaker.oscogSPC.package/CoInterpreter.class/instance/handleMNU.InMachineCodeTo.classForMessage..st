message sending
handleMNU: selectorIndex InMachineCodeTo: rcvr classForMessage: classForMessage
	"A message send from either an open PIC or an unlinked send has not  been
	 understood.  Create a message and execute the relevant resulting MNU method.
	 messageSelector is an implicit argument (yuck)."
	| errSelIdx classForThisMessage |
	self assert: (objectMemory addressCouldBeOop: rcvr).
	instructionPointer := self popStack.
	self createActualMessageTo: classForMessage.
	messageSelector := objectMemory splObj: selectorIndex.
	(self lookupInMethodCacheSel: messageSelector classTag: (objectMemory classTagForClass: lkupClass))
		ifTrue:"check for coggability because method is in the cache"
			[self
				ifAppropriateCompileToNativeCode: newMethod
				selector: messageSelector]
		ifFalse:
			[errSelIdx := self lookupMNUInClass: (classForThisMessage := lkupClass).
			 errSelIdx ~= 0 ifTrue:
				[selectorIndex = SelectorDoesNotUnderstand ifTrue:
					[self error: 'Recursive not understood error encountered'].
				 self push: instructionPointer.
				 ^self handleMNU: errSelIdx InMachineCodeTo: rcvr classForMessage: classForThisMessage]].
	(self maybeMethodHasCogMethod: newMethod) ifTrue:
		[self push: instructionPointer.
		 self executeCogMethod: (self cogMethodOf: newMethod)
			 fromUnlinkedSendWithReceiver: rcvr.
		 "NOTREACHED"
		 self assert: false].
	^self interpretMethodFromMachineCode
	"NOTREACHED"