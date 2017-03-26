accessing
nativeRegisterOrNone
	^(type = SSNativeRegister or: [type = SSRegisterPair])
		 ifTrue: [register]
		 ifFalse: [NoReg]