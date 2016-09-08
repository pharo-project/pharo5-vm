printing
printOn: aStream level: level

	variable printOn: aStream level: level.
	aStream nextPutAll: ' := '.
	expression printOn: aStream level: level + 2.