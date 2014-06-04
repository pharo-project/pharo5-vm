in-line cacheing
offsetAndSendTableFor: entryPoint annotation: annotation into: binaryBlock
	"Find the relevant sendTable for a linked-send to entryPoint.  Do this based on the
	 alignment of entryPoint.  N.B.  For Newspeak sends we don't need to distinguish
	 between ceImplicitReceiver and the other sends since ceImplicitReceiver will
	 never appear to be linked, so only three cases here."
	<inline: true>
	self cppIf: NewspeakVM
		ifTrue:
			[self assert: annotation = IsSendCall.
			 (entryPoint bitAnd: entryPointMask) = checkedEntryAlignment
				ifTrue: [binaryBlock value: cmEntryOffset value: sendTrampolines]
				ifFalse:
					[(entryPoint bitAnd: entryPointMask) = dynSuperEntryAlignment
						ifTrue: [binaryBlock value: cmDynSuperEntryOffset value: dynamicSuperSendTrampolines]
						ifFalse: [binaryBlock value: cmNoCheckEntryOffset value: superSendTrampolines]]]
		ifFalse:
			[(entryPoint bitAnd: entryPointMask) = checkedEntryAlignment
				ifTrue: [binaryBlock value: cmEntryOffset value: sendTrampolines]
				ifFalse: [binaryBlock value: cmNoCheckEntryOffset value: superSendTrampolines]]