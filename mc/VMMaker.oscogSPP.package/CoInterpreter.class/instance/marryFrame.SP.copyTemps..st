frame access
marryFrame: theFP SP: theSP copyTemps: copyTemps
	"Marry an unmarried frame.  This means creating a spouse context
	 initialized with a subset of the frame's state that references the frame.
	 For the default closure implementation we do not need to copy temps.
	 Different closure implementations may require temps to be copied.

	 This method is important enough for performance to be worth streamlining.

	Override to set the ``has context'' flag appropriately for both machine code and interpreter frames
	and to streamline the machine code/interpreter differences.."
	| theContext methodFieldOrObj closureOrNil rcvr numSlots numArgs numStack numTemps |
	<inline: true>
	<var: #theFP type: #'char *'>
	<var: #theSP type: #'char *'>
	<var: #cogMethod type: #'CogMethod *'>
	self assert: (self frameHasContext: theFP) not.
	self assert: (self isBaseFrame: theFP) not. "base frames must aready be married for cannotReturn: processing"

	"The SP is expected to be pointing at the last oop on the stack, not at the pc"
	self assert: (objectMemory addressCouldBeOop: (objectMemory longAt: theSP)).

	"Decide how much of the stack to preserve in widowed contexts.  Preserving too much
	 state will potentially hold onto garbage.  Holding onto too little may mean that a dead
	 context isn't informative enough in a debugging situation.  If copyTemps is false (as it
	 is in the default closure implementation) compromise, retaining only the arguments with
	 no temporaries.  Note that we still set the stack pointer to its current value, but stack
	 contents other than the arguments are nil."
	methodFieldOrObj := self frameMethodField: theFP.
	methodFieldOrObj asUnsignedInteger < objectMemory startOfMemory "inline (self isMachineCodeFrame: theFP)"
		ifTrue:
			[| cogMethod |
			 stackPages
				longAt: theFP + FoxMethod
				put: methodFieldOrObj + MFMethodFlagHasContextFlag.
			 cogMethod := self cCoerceSimple: (methodFieldOrObj bitAnd: MFMethodMask) to: #'CogMethod *'.
			 numArgs := cogMethod cmNumArgs.
			 cogMethod cmType = CMMethod
				ifTrue:
					[closureOrNil := cogMethod cmIsFullBlock
										ifTrue: [self frameStackedReceiver: theFP numArgs: numArgs]
										ifFalse: [objectMemory nilObject]]
				ifFalse:
					[cogMethod := (self cCoerceSimple: cogMethod to: #'CogBlockMethod *') cmHomeMethod.
					 closureOrNil := self frameStackedReceiver: theFP numArgs: numArgs].
			 numSlots := (self methodHeaderIndicatesLargeFrame: cogMethod methodHeader)
							ifTrue: [LargeContextSlots]
							ifFalse: [SmallContextSlots].
			 methodFieldOrObj := cogMethod methodObject.
			 rcvr := self mframeReceiver: theFP.
			 numStack := self stackPointerIndexForMFrame: theFP WithSP: theSP numArgs: numArgs]
		ifFalse:
			[self setIFrameHasContext: theFP.
			 numArgs := self iframeNumArgs: theFP.
			 numSlots := (self methodHeaderIndicatesLargeFrame: (objectMemory methodHeaderOf: methodFieldOrObj))
							ifTrue: [LargeContextSlots]
							ifFalse: [SmallContextSlots].
			 closureOrNil := (self iframeIsBlockActivation: theFP)
								ifTrue: [self frameStackedReceiver: theFP numArgs: numArgs]
								ifFalse: [objectMemory nilObject].
			 rcvr := self iframeReceiver: theFP.
			 numStack := self stackPointerIndexForIFrame: theFP WithSP: theSP numArgs: numArgs].
	theContext := objectMemory eeInstantiateMethodContextSlots: numSlots.
	self setFrameContext: theFP to: theContext.
	"Mark context as married by setting its sender to the frame pointer plus SmallInteger
	 tags and the InstructionPointer to the saved fp (which ensures correct alignment
	 w.r.t. the frame when we check for validity)"
	objectMemory storePointerUnchecked: SenderIndex
		ofObject: theContext
		withValue: (self withSmallIntegerTags: theFP).
	objectMemory storePointerUnchecked: InstructionPointerIndex
		ofObject: theContext
		withValue: (self withSmallIntegerTags: (self frameCallerFP: theFP)).
	objectMemory storePointerUnchecked: StackPointerIndex
		ofObject: theContext
		withValue: (objectMemory integerObjectOf: numStack).
	objectMemory storePointerUnchecked: MethodIndex
		ofObject: theContext
		withValue: methodFieldOrObj.
	objectMemory storePointerUnchecked: ClosureIndex ofObject: theContext withValue: closureOrNil.
	objectMemory storePointerUnchecked: ReceiverIndex
		ofObject: theContext
		withValue: rcvr.
	1 to: numArgs do:
		[:i|
		objectMemory storePointerUnchecked: ReceiverIndex + i
			ofObject: theContext
			withValue: (self temporary: i - 1 in: theFP)].
	copyTemps ifTrue:
		[numTemps := self frameNumTemps: theFP.
		 1 to: numTemps do:
			[:i|
			objectMemory storePointerUnchecked: ReceiverIndex + i + numArgs
				ofObject: theContext
				withValue: (self temporary: i - 1 in: theFP)].
		 numArgs := numArgs + numTemps].

	numArgs + 1 to: numStack do:
		[:i|
		objectMemory storePointerUnchecked: ReceiverIndex + i
			ofObject: theContext
			withValue: objectMemory nilObject].

	self assert: (self frameHasContext: theFP).
	self assert: (self frameOfMarriedContext: theContext) = theFP.
	self assert: numStack + ReceiverIndex < (objectMemory lengthOf: theContext).

	^theContext