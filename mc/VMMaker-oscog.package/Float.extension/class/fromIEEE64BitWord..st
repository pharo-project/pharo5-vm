*VMMaker-instance creation
fromIEEE64BitWord: anInteger
	^(self basicNew: 2)
		basicAt: 1 put: (anInteger bitShift: -32);
		basicAt: 2 put: (anInteger bitAnd: 16rFFFFFFFF);
		yourself