utils
dirFrom: aStringOrDir
	^ aStringOrDir isString
		ifTrue: [ aStringOrDir asFileReference ]
		ifFalse: [ aStringOrDir ]