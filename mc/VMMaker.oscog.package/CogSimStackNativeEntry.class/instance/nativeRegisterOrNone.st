accessing
nativeRegisterOrNone
	^(type = SSRegister or: [type = SSRegisterPair])
		 ifTrue: [register]
		 ifFalse: [NoReg]