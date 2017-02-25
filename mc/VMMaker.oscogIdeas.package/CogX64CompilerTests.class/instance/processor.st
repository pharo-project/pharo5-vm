accessing
processor
	processor ifNil:
		[processor := BochsX64Alien new].
	^processor