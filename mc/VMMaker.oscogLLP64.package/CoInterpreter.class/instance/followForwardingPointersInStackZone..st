object memory support
followForwardingPointersInStackZone: theBecomeEffectsFlags
	"Spur's become: is lazy, turning the becommed object into a forwarding object to the other.
	 The read-barrier is minimised by arranging that forwarding pointers will fail a method cache
	 probe, since notionally objects' internals are accessed only via sending messages to them,
	 the exception is primitives that access the internals of the non-receiver argument(s).

	 To avoid a read barrier on bytecode, literal and inst var fetch and non-local return, we scan
	 the receivers (including the stacked receiver for non-local return) and method references
	 in the stack zone and follow any forwarded ones.  This is of course way cheaper than
	 scanning all of memory as in the old become.

	 Override to handle machine code frames"
	| theIPPtr |
	<inline: false>
	<var: #theSP type: #'char *'>
	<var: #theFP type: #'char *'>
	<var: #theIPPtr type: #usqInt>
	<var: #callerFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>

	self externalWriteBackHeadFramePointers.

	(theBecomeEffectsFlags anyMask: BecameCompiledMethodFlag) ifTrue:
		[(objectMemory isForwarded: method) ifTrue:
			[theIPPtr := instructionPointer - method.
			 method := objectMemory followForwarded: method.
			 instructionPointer := method + theIPPtr].
		(objectMemory isOopForwarded: newMethod) ifTrue:
			[newMethod := objectMemory followForwarded: newMethod]].

	self assert: stackPage ~= 0.
	0 to: numStackPages - 1 do:
		[:i| | thePage theSP theFP callerFP oop offset |
		thePage := stackPages stackPageAt: i.
		thePage isFree ifFalse:
			[self assert: (self ifCurrentStackPageHasValidHeadPointers: thePage).
			 theFP := thePage headFP.
			 "Skip the instruction pointer on top of stack of inactive pages."
			 theIPPtr := thePage = stackPage ifTrue: [0] ifFalse: [thePage headSP asUnsignedInteger].
			 [self assert: (thePage addressIsInPage: theFP).
			  self assert: (theIPPtr = 0 or: [thePage addressIsInPage: theIPPtr asVoidPointer]).
			  (self isMachineCodeFrame: theFP)
				ifTrue:
					[oop := stackPages longAt: theFP + FoxMFReceiver.
					 (objectMemory isOopForwarded: oop) ifTrue:
						[stackPages
							longAt: theFP + FoxMFReceiver
							put: (objectMemory followForwarded: oop)].
					 self assert: (objectMemory isForwarded: (self mframeHomeMethod: theFP) methodObject) not]
				ifFalse:
					[oop := stackPages longAt: theFP + FoxIFReceiver.
					 (objectMemory isOopForwarded: oop) ifTrue:
						[stackPages
							longAt: theFP + FoxIFReceiver
							put: (objectMemory followForwarded: oop)].
					 oop := self iframeMethod: theFP.
					 (objectMemory isForwarded: oop) ifTrue:
						[| newOop |
						 newOop := objectMemory followForwarded: oop.
						 offset := newOop - oop.
						 (theIPPtr ~= 0
						  and: [(stackPages longAt: theIPPtr) > oop]) ifTrue:
							[stackPages
								longAt: theIPPtr
								put: (stackPages longAt: theIPPtr) + offset].
						stackPages
							longAt: theFP + FoxIFSavedIP
							put: (stackPages longAt: theFP + FoxIFSavedIP) + offset.
						stackPages
							longAt: theFP + FoxMethod
							put: (oop := newOop)]].
			  ((self frameHasContext: theFP)
			   and: [(objectMemory isForwarded: (self frameContext: theFP))]) ifTrue:
				[stackPages
					longAt: theFP + FoxThisContext
					put: (objectMemory followForwarded: (self frameContext: theFP))].
			  offset := self frameStackedReceiverOffset: theFP.
			  oop := stackPages longAt: theFP + offset.
			  (objectMemory isOopForwarded: oop) ifTrue:
				[stackPages
					longAt: theFP + offset
					put: (objectMemory followForwarded: oop)].
			  (callerFP := self frameCallerFP: theFP) ~= 0] whileTrue:
				[theIPPtr := (theFP + FoxCallerSavedIP) asUnsignedInteger.
				 theFP := callerFP].
			 "And finally follow the saved context and the caller context."
			 theSP := thePage baseAddress - objectMemory wordSize.
			 [theSP <= thePage baseAddress] whileTrue:
				[oop := stackPages longAt: theSP.
				 (objectMemory isForwarded: oop) ifTrue:
					[stackPages longAt: theSP put: (objectMemory followForwarded: oop)].
				 theSP := theSP + objectMemory wordSize]]]