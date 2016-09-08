translation
cogMethodClass: options
	^(options at: #NewspeakVM ifAbsent: [false])
		ifTrue: [NewspeakCogMethod]
		ifFalse: [CogMethod]