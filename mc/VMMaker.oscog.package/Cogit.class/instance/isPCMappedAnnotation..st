method map
isPCMappedAnnotation: annotation
	<inline: true>
	^annotation >= IsSendCall
	  or: [annotation = HasBytecodePC
	  or: [NewspeakVM and: [annotation = IsNSSendCall]]]