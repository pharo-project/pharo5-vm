accessing
nflag: unsignedInteger
"The ARM cpsr flags are kept as individual fields in the Alien structure. The address here is the 1-based byte offset into the ARMul_State structure"
	^self unsignedLongAt: 565 put: unsignedInteger