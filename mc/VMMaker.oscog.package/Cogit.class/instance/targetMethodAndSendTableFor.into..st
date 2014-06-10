in-line cacheing
targetMethodAndSendTableFor: entryPoint into: binaryBlock
	"Evaluate binaryBlock with the targetMethod and relevant send table for a linked-send
	 to entryPoint.  Do so based on the alignment of entryPoint.  N.B.  For Newspeak sends
	 we don't need to distinguish between ceImplicitReceiver and the other sends since
	 ceImplicitReceiver will never appear to be linked, so only three cases here."
	<inline: true>
	| targetMethod sendTable |
	<var: #targetMethod type: #'CogMethod *'>
	<var: #sendTable type: #'sqInt *'>
	self cppIf: NewspeakVM
		ifTrue:
			[(entryPoint bitAnd: entryPointMask) = checkedEntryAlignment
				ifTrue:
					[targetMethod := self cCoerceSimple: entryPoint - cmEntryOffset to: #'CogMethod *'.
					 sendTable := sendTrampolines]
				ifFalse:
					[(entryPoint bitAnd: entryPointMask) = dynSuperEntryAlignment
						ifTrue:
							[targetMethod := self cCoerceSimple: entryPoint - cmDynSuperEntryOffset to: #'CogMethod *'.
							 sendTable := dynamicSuperSendTrampolines]
						ifFalse:
							[targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
							 sendTable := superSendTrampolines]]]
		ifFalse:
			[(entryPoint bitAnd: entryPointMask) = checkedEntryAlignment
				ifTrue:
					[targetMethod := self cCoerceSimple: entryPoint - cmEntryOffset to: #'CogMethod *'.
					 sendTable := sendTrampolines]
				ifFalse:
					[targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
					 sendTable := superSendTrampolines]].
	binaryBlock
		value: targetMethod
		value: sendTable