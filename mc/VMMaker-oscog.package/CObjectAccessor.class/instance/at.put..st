accessing
at: index put: value
	^object instVarAt: index + offset + 1 put: value