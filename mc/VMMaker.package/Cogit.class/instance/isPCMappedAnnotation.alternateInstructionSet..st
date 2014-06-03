method map
isPCMappedAnnotation: annotation alternateInstructionSet: isAlternateInstSet
	<inline: true>
	^self cppIf: NewspeakVM
		ifTrue:
			"For Newspeak we shoe-horn in implicit receiver inline cache handling as an inline
			 send, since these caches are processed similarly to inline send caches.  But if
			 the Newspeak instruction set includes an absent receiver send then there are
			 two map entries for the one bytecode, the first for the implicit receiver cache
			 and the second for the send cache. Only one of these can function as the pc-
			 mapped entry since there is only one bytecode. c.f. isSendAnnotation:"
			[annotation = IsSendCall
			or: [(annotation = IsNSSendCall
				and: [isAlternateInstSet
						ifTrue: [AltNSSendIsPCAnnotated]
						ifFalse: [NSSendIsPCAnnotated]])
			or: [annotation = HasBytecodePC]]]
		ifFalse:
			[(self isSendAnnotation: annotation)
			  or: [annotation = HasBytecodePC]]