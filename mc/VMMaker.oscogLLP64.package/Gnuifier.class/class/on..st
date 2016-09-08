as yet unclassified
on: aFilePathStringOrDirectory

	^self new setDirectory: (aFilePathStringOrDirectory isString
								ifTrue: [FileDirectory on: aFilePathStringOrDirectory]
								ifFalse: [aFilePathStringOrDirectory])