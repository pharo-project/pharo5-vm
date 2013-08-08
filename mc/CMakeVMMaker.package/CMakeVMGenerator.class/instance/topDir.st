accessing
topDir
	| dir |
	dir := self config topDir ifNil: [ FileSystem workingDirectory parent ].
	dir isString
		ifTrue: [ ^dir asFileReference ].
	^ dir