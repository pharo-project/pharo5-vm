accessing
processor
	processor ifNil:
		[processor := GdbARMAlien new].
	^processor