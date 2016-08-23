directory primitives
asciiDirectoryDelimiter
	^ self
		cCode: 'dir_Delimitor()'
		inSmalltalk:
			[(Smalltalk classNamed: #FileSystem)
				ifNotNil: [:fileSystem| fileSystem disk delimiter asciiValue]
				ifNil: [FileDirectory pathNameDelimiter asciiValue]]