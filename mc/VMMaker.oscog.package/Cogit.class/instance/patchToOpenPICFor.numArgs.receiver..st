in-line cacheing
patchToOpenPICFor: selector numArgs: numArgs receiver: receiver
	"Code entry closed PIC full or miss to an instance of a young class or to a young target method.
	 Attempt to patch the send site to an open PIC.  Answer if the attempt succeeded; in fact it will
	 only return if the attempt failed.
	 The stack looks like:
			receiver
			args
	 sp=>	sender return address"
	<api>
	| oPIC outerReturn extent |
	<var: #oPIC type: #'CogMethod *'>
	outerReturn := coInterpreter stackTop.
	"See if an Open PIC is already available."
	oPIC := methodZone openPICWithSelector: selector.
	oPIC isNil ifTrue:
		["otherwise attempt to create an Open PIC."
		oPIC := self cogOpenPICSelector: selector numArgs: numArgs.
		(oPIC asInteger between: MaxNegativeErrorCode and: -1) ifTrue:
			["For some reason the PIC couldn't be generated, most likely a lack of code memory."
			oPIC asInteger = InsufficientCodeSpace ifTrue:
				[coInterpreter callForCogCompiledCodeCompaction].
			^false]].
	extent := backEnd
				rewriteInlineCacheAt: outerReturn
				tag: selector
				target: oPIC asInteger + cmEntryOffset.
	processor
		flushICacheFrom: outerReturn - 1 - extent to: outerReturn - 1;
		flushICacheFrom: oPIC asInteger to: oPIC asInteger + openPICSize.
	"Jump into the oPIC at its entry"
	coInterpreter executeCogMethod: oPIC fromLinkedSendWithReceiver: receiver.
	"NOTREACHED"
	^true