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
	oPIC ifNil:
		["otherwise attempt to create an Open PIC."
		oPIC := self cogOpenPICSelector: selector numArgs: numArgs.
		(oPIC asInteger between: MaxNegativeErrorCode and: -1) ifTrue:
			["For some reason the PIC couldn't be generated, most likely a lack of code memory."
			oPIC asInteger = InsufficientCodeSpace ifTrue:
				[coInterpreter callForCogCompiledCodeCompaction].
			^false]].
	"Relink the send site to the pic.  Reset the cache tag to the selector, for the
	 benefit of the cacheTag assert check in checkIfValidOopRef:pc:cogMethod: et al."
	extent := backEnd
				rewriteInlineCacheAt: outerReturn
				tag: (self inlineCacheValueForSelector: selector
						  in: coInterpreter mframeHomeMethodExport
						  at: outerReturn)
				target: oPIC asInteger + cmEntryOffset.
	processor
		flushICacheFrom: outerReturn asUnsignedInteger - extent to: outerReturn asUnsignedInteger;
		flushICacheFrom: oPIC asUnsignedInteger to: oPIC asUnsignedInteger + openPICSize.
	"Jump into the oPIC at its entry"
	coInterpreter executeCogMethod: oPIC fromLinkedSendWithReceiver: receiver.
	"NOTREACHED"
	^true