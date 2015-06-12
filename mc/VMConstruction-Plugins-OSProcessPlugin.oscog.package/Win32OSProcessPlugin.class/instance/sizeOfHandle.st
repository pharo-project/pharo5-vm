private - handle conversion
sizeOfHandle
	<inline: true>
	^self cCode: 'sizeof(HANDLE)' inSmalltalk: [interpreterProxy wordSize]