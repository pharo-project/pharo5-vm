directory primitives
asciiDirectoryDelimiter
	^ self cCode: 'dir_Delimitor()' inSmalltalk: [FileSystem disk delimiter asciiValue]