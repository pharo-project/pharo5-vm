accessing
longAt: index put: value
	^memory longAt: index + 1 put: value bigEndian: false