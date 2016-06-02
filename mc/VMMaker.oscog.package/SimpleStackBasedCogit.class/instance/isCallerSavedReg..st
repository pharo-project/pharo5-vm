register management
isCallerSavedReg: reg
	<inline: true>
	^self register: reg isInMask: CallerSavedRegisterMask