object memory support
followForwardingPointersInStackZone: theBecomeEffectsFlags
	"Spur's become: is lazy, turning the becommed object into a forwarding object to the other.
	 The read-barrier is minimised by arranging that forwarding pointers will fail a method cache
	 probe, since notionally objects' internals are accessed only via sending messages to them,
	 the exception is primitives that access the internals of the non-receiver argument(s).
	 To avoid a read barrier on bytecode, literal and inst var fetch we scan the receivers and
	 methods in the stack zone and follow any forwarded ones.  This is of course way cheaper
	 than scanning all of memory as in the old become."
	| theIPPtr |
	<inline: false>
	<var: #thePage type: #'StackPage *'>
	<var: #theSP type: #'char *'>
	<var: #theFP type: #'char *'>
	<var: #callerFP type: #'char *'>
	<var: #theIPPtr type: #usqInt>

	(theBecomeEffectsFlags anyMask: BecameCompiledMethodFlag) ifTrue:
		[(objectMemory isForwarded: method) ifTrue:
			[theIPPtr := instructionPointer - method.
			 method := objectMemory followForwarded: method.
			 instructionPointer := method + theIPPtr].
		(objectMemory isForwarded: newMethod) ifTrue:
			[newMethod := objectMemory followForwarded: newMethod]].

	self assert: stackPage ~= 0.
	0 to: numStackPages - 1 do:
		[:i| | thePage theSP theFP callerFP oop offset |
		thePage := stackPages stackPageAt: i.
		thePage isFree ifFalse:
			[theSP := thePage headSP.
			 theFP := thePage  headFP.
			 "Skip the instruction pointer on top of stack of inactive pages."
			 thePage = stackPage
				ifTrue: [theIPPtr := 0]
				ifFalse:
					[theIPPtr := theSP asUnsignedInteger.
					 theSP := theSP + BytesPerWord].
			 [self assert: (thePage addressIsInPage: theFP).
			  self assert: (theIPPtr = 0 or: [thePage addressIsInPage: theIPPtr asVoidPointer]).
			  offset := self frameStackedReceiverOffset: theFP.
			  oop := stackPages longAt: theFP + offset.
			  (objectMemory isOopForwarded: oop) ifTrue:
				[stackPages
					longAt: theFP + offset
					put: (objectMemory followForwarded: oop)].
			  ((self frameHasContext: theFP)
			   and: [(objectMemory isForwarded: (self frameContext: theFP))]) ifTrue:
				[stackPages
					longAt: theFP + FoxThisContext
					put: (objectMemory followForwarded: (self frameContext: theFP))].
			 (self isMachineCodeFrame: theFP)
				ifTrue:
					[oop := stackPages longAt: theFP + FoxMFReceiver.
					 (objectMemory isOopForwarded: oop) ifTrue:
						[stackPages
							longAt: theFP + FoxMFReceiver
							put: (objectMemory followForwarded: oop)].
					 oop := (self mframeHomeMethod: theFP) methodObject.
					 self assert: (objectMemory isForwarded: oop) not]
				ifFalse:
					[oop := stackPages longAt: theFP + FoxIFReceiver.
					 (objectMemory isOopForwarded: oop) ifTrue:
						[stackPages
							longAt: theFP + FoxIFReceiver
							put: (objectMemory followForwarded: oop)].
					 oop := self iframeMethod: theFP.
					 (objectMemory isForwarded: oop) ifTrue:
						[| newOop delta |
						 newOop := objectMemory followForwarded: oop.
						 delta := newOop - oop.
						 (theIPPtr ~= 0
						  and: [(stackPages longAt: theIPPtr) > oop]) ifTrue:
							[stackPages
								longAt: theIPPtr
								put: (stackPages longAt: theIPPtr) + delta].
						stackPages
							longAt: theFP + FoxIFSavedIP
							put: (stackPages longAt: theFP + FoxIFSavedIP) + delta.
						stackPages
							longAt: theFP + FoxMethod
							put: (oop := newOop)]].
			  self followNecessaryForwardingInMethod: oop.
			  (callerFP := self frameCallerFP: theFP) ~= 0] whileTrue:
				[theIPPtr := (theFP + FoxCallerSavedIP) asUnsignedInteger.
				 theFP := callerFP]]]