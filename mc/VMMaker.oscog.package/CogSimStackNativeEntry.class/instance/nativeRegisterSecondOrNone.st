accessing
nativeRegisterSecondOrNone
	^type = SSRegisterPair
		 ifTrue: [registerSecond]
		 ifFalse: [NoReg]