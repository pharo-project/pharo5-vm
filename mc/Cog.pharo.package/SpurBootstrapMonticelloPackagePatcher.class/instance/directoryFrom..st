initialization
directoryFrom: dirName
	^FileDirectory on: (dirName first = $/
							ifTrue: [dirName]
							ifFalse: [(FileDirectory default directoryNamed: dirName) fullName])