trampolines
ceSendFromInLineCacheMiss: oPIC
	"Send from an Open PIC when the first-level method lookup probe has failed,
	 or to continue when PIC creation has failed (e.g. because we're out of code space)."
	<api>
	<var: #oPIC type: #'CogMethod *'>
	| numArgs rcvr classTag errSelIdx |
	"self printFrame: stackPage headFP WithSP: stackPage headSP"
	"self printStringOf: selector"
	numArgs := oPIC cmNumArgs.
	rcvr := self stackValue: numArgs + 1. "skip return pc"
	self assert: ((objectMemory isIntegerObject: rcvr) or: [objectMemory addressCouldBeObj: rcvr]).
	classTag := objectMemory fetchClassTagOf: rcvr.
	argumentCount := numArgs.
	(self lookupInMethodCacheSel: oPIC selector classTag: classTag)
		ifTrue:"check for coggability because method is in the cache"
			[self
				ifAppropriateCompileToNativeCode: newMethod
				selector: oPIC selector]
		ifFalse:
			[messageSelector := oPIC selector.
			 (errSelIdx := self lookupMethodNoMNUEtcInClass: (objectMemory classForClassTag: classTag)) ~= 0 ifTrue:
				[self handleMNU: errSelIdx InMachineCodeTo: rcvr classForMessage: (objectMemory classForClassTag: classTag).
				"NOTREACHED"
				self assert: false]].
	instructionPointer := self popStack.
	(self maybeMethodHasCogMethod: newMethod) ifTrue:
		[self executeNewMethod.
		 self assert: false
		 "NOTREACHED"].
	^self interpretMethodFromMachineCode
	"NOTREACHED"