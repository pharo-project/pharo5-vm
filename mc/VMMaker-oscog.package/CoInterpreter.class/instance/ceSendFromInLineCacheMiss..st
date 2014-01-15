trampolines
ceSendFromInLineCacheMiss: oPIC
	"Send from an Open PIC when the first-level method lookup probe has failed,
	 or to continue when PIC creation has failed (e.g. because we're out of code space)."
	<api>
	<var: #oPIC type: #'CogMethod *'>
	| numArgs rcvr class errSelIdx |
	"self printFrame: stackPage headFP WithSP: stackPage headSP"
	"self printStringOf: selector"
	numArgs := oPIC cmNumArgs.
	rcvr := self stackValue: numArgs + 1. "skip return pc"
	self assert: ((objectMemory isIntegerObject: rcvr) or: [objectMemory addressCouldBeObj: rcvr]).
	class := objectMemory fetchClassOf: rcvr.
	argumentCount := numArgs.
	"We set the messageSelector and lkupClass for executeMethod below since things
	 like the at cache read messageSelectorand lkupClass and so they cannot be left stale."
	messageSelector := oPIC selector.
	lkupClass := class.
	(self lookupInMethodCacheSel: oPIC selector class: class)
		ifTrue:"check for coggability because method is in the cache"
			[self
				ifAppropriateCompileToNativeCode: newMethod
				selector: oPIC selector]
		ifFalse:
			[(errSelIdx := self lookupMethodNoMNUEtcInClass: class) ~= 0 ifTrue:
				[self handleMNU: errSelIdx InMachineCodeTo: rcvr classForMessage: class.
				"NOTREACHED"
				self assert: false]].
	instructionPointer := self popStack.
	(self maybeMethodHasCogMethod: newMethod) ifTrue:
		[self executeNewMethod.
		 self assert: false
		 "NOTREACHED"].
	^self interpretMethodFromMachineCode
	"NOTREACHED"