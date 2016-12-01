class initialization
initializeMiscConstants
	super initializeMiscConstants.
	initializationOptions
		at: #ABI
		ifPresent: [:abi| SysV := abi asUppercase ~= #WIN64]
		ifAbsent: [SysV := true]. "Default ABI; set to true for SysV, false for WIN64"
