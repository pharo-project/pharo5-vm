method map
isSendAnnotation: annotation
	<inline: true>
	^annotation >= IsSendCall
	  or: [NewspeakVM and: [annotation = IsNSSendCall]]