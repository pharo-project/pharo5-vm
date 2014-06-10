as yet unclassified
on: aFilePathStringOrDirectory
	^ self new
		setDirectory:
			(aFilePathStringOrDirectory isString
				ifTrue: [ aFilePathStringOrDirectory asFileReference ]
				ifFalse: [ aFilePathStringOrDirectory ])