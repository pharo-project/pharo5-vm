accessing
tflag: unsignedInteger
"The ARM cpsr flags are kept as individual fields in the Alien structure. The address here is the 1-based byte offset into the ARMul_State structure"
"This would be the Thumb flag if we have it -which depends rather oddly on the compiletime flags used to build the ARMulator. Sigh"
	^self unsignedLongAt: 589 put: unsignedInteger