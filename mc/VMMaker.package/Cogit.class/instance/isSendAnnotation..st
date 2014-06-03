method map
isSendAnnotation: annotation
	<inline: true>
	^self cppIf: NewspeakVM
		ifTrue: [annotation = IsSendCall or: [annotation = IsNSSendCall]]
		ifFalse: [annotation = IsSendCall]