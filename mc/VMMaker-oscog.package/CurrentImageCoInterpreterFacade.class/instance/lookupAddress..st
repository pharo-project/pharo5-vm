labels
lookupAddress: address
	^(objectMap
		keyAtValue: address
		ifAbsent:
			[variables
				keyAtValue: address
				ifAbsent: [^nil]]) asString