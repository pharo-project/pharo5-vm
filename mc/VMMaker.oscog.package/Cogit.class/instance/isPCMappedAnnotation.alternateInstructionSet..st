method map
isPCMappedAnnotation: annotation alternateInstructionSet: isAlternateInstSet
	<inline: true>
	^self cppIf: NewspeakVM
		ifTrue:
			[annotation = IsSendCall
			or: [annotation = IsNSSendCall
			or: [annotation = HasBytecodePC]]]
		ifFalse:
			[(annotation = IsSendCall)
			  or: [annotation = HasBytecodePC]]