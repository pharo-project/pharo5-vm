cog jit support
ceCounterTripped: condition
	<api>
	<option: #SistaStackToRegisterMappingCogit>
	"Send e.g. thisContext conditionalBranchCounterTrippedOn: boolean."
	| context counterTrippedSelector |
	counterTrippedSelector := objectMemory maybeSplObj: SelectorCounterTripped.
	(counterTrippedSelector isNil
	or: [counterTrippedSelector = objectMemory nilObject]) ifTrue:
		[cogit resetCountersIn: (self mframeHomeMethod: framePointer).
		 ^condition].
	
	lkupClass := self splObj: ClassMethodContext.
	(self lookupInMethodCacheSel: counterTrippedSelector class: lkupClass) ifFalse:
	 	[messageSelector := counterTrippedSelector.
		 (self lookupMethodNoMNUEtcInClass: lkupClass) ~= 0 ifTrue:
			[cogit resetCountersIn: (self mframeHomeMethod: framePointer).
			 ^condition]].

	(primitiveFunctionPointer ~= 0
	or: [(self argumentCountOf: newMethod) ~= 1]) ifTrue:
		[cogit resetCountersIn: (self mframeHomeMethod: framePointer).
		 ^condition].

	instructionPointer := self popStack.
	context := self ensureFrameIsMarried: framePointer SP: stackPointer.
	self push: context.
	self push: condition.
	self ifAppropriateCompileToNativeCode: newMethod selector: messageSelector.
	self activateNewMethod.
	"not reached"
	^true