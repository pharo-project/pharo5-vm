trampolines
ceOuterSend: cacheAddress receiver: methodReceiver
	"An outer send cache missed."
	| nsSendCache methodMixin numArgs selector depth enclosingObject cogMethod eoClassTag mrClassTag errSelIdx |
	<api>
	<option: #NewspeakVM>
	<inline: false>
	<var: #nsSendCache type: #'NSSendCache *'>
	<var: #cogMethod type: #'CogMethod *'>

	cogit assertCStackWellAligned.
	self assert: (objectMemory addressCouldBeOop: methodReceiver).

	nsSendCache := self cCoerceSimple: cacheAddress to: #'NSSendCache *'.
	selector := nsSendCache selector.
	numArgs := nsSendCache numArgs.
	depth := nsSendCache depth.
	methodMixin := self mMethodClass.

	enclosingObject := self
		enclosingObjectAt: depth
		withObject: methodReceiver
		withMixin: methodMixin.

	self assert: (self stackValue: numArgs + 1 "ret val") = methodReceiver.
	self stackValue: numArgs + 1 "ret val " put: enclosingObject.
	"Replace the methodReceiver on the stack with the enclosingObject. When the cache has
	a hit, we don't care that the value on the stack is wrong because the compiled callee will
	use the value in ReceiverResultReg to build its frame. But the interpreter will use
	stack(numArgs)."

	mrClassTag := objectMemory fetchClassTagOf: methodReceiver.
	eoClassTag := objectMemory fetchClassTagOf: enclosingObject.
	argumentCount := numArgs.

	(self lookupInMethodCacheSel: selector classTag: eoClassTag)
		ifTrue: ["check for coggability because method is in the cache"
			self ifAppropriateCompileToNativeCode: newMethod selector: selector]
		ifFalse: [
			(objectMemory isOopForwarded: selector) ifTrue:
				[self error: 'Selector should have fixed by mapObjectReferencesInMachineCodeForBecome'].
			(objectMemory isForwardedClassTag: eoClassTag) ifTrue:
				[self error: 'Implicit receiver lookup should have followed fowarded objects'].
			messageSelector := selector.
			(errSelIdx := self lookupMethodNoMNUEtcInClass: (objectMemory classForClassTag: eoClassTag)) ~= 0
				ifTrue: [[self handleMNU: errSelIdx InMachineCodeTo: enclosingObject classForMessage: (objectMemory classForClassTag: eoClassTag).
						self error: 'UNREACHABLE3']]].

	(self maybeMethodHasCogMethod: newMethod) 
		ifTrue: [
			cogMethod := self cogMethodOf: newMethod.
			cogMethod selector = objectMemory nilObject
				ifTrue: [cogit setSelectorOf: cogMethod to: selector]
				ifFalse: ["Deal with anonymous accessors, e.g. in Newspeak.
					The cogMethod may not have the
					correct selector. If not, try and compile a new method
					with the correct selector."
					cogMethod selector ~= selector ifTrue: [
							(cogit cog: newMethod selector: selector)
								ifNotNil: [:newCogMethod | cogMethod := newCogMethod]]].
			cogMethod selector = selector
				ifTrue:
					[cogit
						linkNSSendCache: nsSendCache 
						classTag: mrClassTag
						enclosingObject: enclosingObject
						target: cogMethod
						caller: self mframeHomeMethodExport]
				ifFalse: [self error: 'What does this mean? C.f. case in ceSend:...'].
			instructionPointer := self popStack.
			self executeNewMethod.
			self error: 'UNREACHABLE 1'].
	instructionPointer := self popStack.
	self interpretMethodFromMachineCode.
	self error: 'UNREACHABLE 2'.
	^nil