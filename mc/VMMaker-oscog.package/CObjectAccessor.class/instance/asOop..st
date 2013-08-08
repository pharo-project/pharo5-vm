converting
asOop: aClass

	(aClass ccgCanConvertFrom: object)
		ifFalse: [^self error: 'incompatible object for autocoercion'].
	^object