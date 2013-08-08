private - handle conversion
sizeOfHandle

	^ self cCode: 'sizeof(HANDLE)' inSmalltalk: [4]
