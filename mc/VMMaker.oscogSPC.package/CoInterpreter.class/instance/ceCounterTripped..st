cog jit support
ceCounterTripped: condition
	"Two things are going on here.  The main one is catching a counter trip and attempting
	 to send the SelectorCounterTripped selector.  In this case we would like to back-up
	 the pc to the return address of the send that yields the boolean to be tested, so that
	 after potential optimization, computation proceeds by retrying the jump.  But we cannot,
	 since there may be no send, just a pop (as in and: [] and or: [] chains).  In this case we also
	 want to prevent further callbacks until optimization is complete.  So we nil-out the
	 SelectorCounterTripped entry in the specialSelectorArray.

	 The minor case is that there is an unlikely  possibility that the cointer tripped but condition
	 is not a boolean, in which case a mustBeBoolean response should occur."
	<api>
	<option: #SistaCogit>
	"Send e.g. thisContext conditionalBranchCounterTrippedOn: boolean."
	| context counterTrippedSelector classTag classObj |
	(condition = objectMemory falseObject
	or: [condition = objectMemory trueObject]) ifFalse:
		[^self ceSendMustBeBoolean: condition].

	counterTrippedSelector := objectMemory maybeSplObj: SelectorCounterTripped.
	(counterTrippedSelector isNil
	or: [counterTrippedSelector = objectMemory nilObject]) ifTrue:
		[cogit resetCountersIn: (self mframeHomeMethod: framePointer).
		 ^condition].

	classTag := objectMemory
					classTagForSpecialObjectsIndex: ClassMethodContext
					compactClassIndex: ClassMethodContextCompactIndex.
	(self lookupInMethodCacheSel: counterTrippedSelector classTag: classTag) ifFalse:
	 	[messageSelector := counterTrippedSelector.
		 classObj := objectMemory classForClassTag: classTag.
		 (self lookupOrdinaryNoMNUEtcInClass: classObj) ~= 0 ifTrue:
			[cogit resetCountersIn: (self mframeHomeMethod: framePointer).
			 ^condition].
		 self addNewMethodToCache: classObj].

	(primitiveFunctionPointer ~= 0
	or: [(self argumentCountOf: newMethod) ~= 1]) ifTrue:
		[cogit resetCountersIn: (self mframeHomeMethod: framePointer).
		 ^condition].

	objectMemory splObj: SelectorCounterTripped put: objectMemory nilObject.
	instructionPointer := self popStack.
	context := self ensureFrameIsMarried: framePointer SP: stackPointer.
	self push: context.
	self push: condition.
	self ifAppropriateCompileToNativeCode: newMethod selector: counterTrippedSelector.
	self activateNewMethod.
	"not reached"
	^true