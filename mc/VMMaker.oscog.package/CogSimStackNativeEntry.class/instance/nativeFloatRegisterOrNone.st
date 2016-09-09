accessing
nativeFloatRegisterOrNone
	^ ([type = SSRegisterSingleFloat] or: [type = SSRegisterDoubleFloat])
		 ifTrue: [register]
		 ifFalse: [NoReg]