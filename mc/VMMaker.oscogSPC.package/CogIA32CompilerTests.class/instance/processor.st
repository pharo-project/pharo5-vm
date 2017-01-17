accessing
processor
	processor ifNil:
		[processor := BochsIA32Alien new].
	^processor