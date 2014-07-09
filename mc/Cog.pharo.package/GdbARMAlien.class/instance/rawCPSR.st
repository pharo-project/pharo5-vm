accessing
rawCPSR
"The ARM cpsr flags are kept as individual fields in the Alien structure. The address here is the 1-based byte offset into the ARMul_State structure"
"read the raw value of the cpsr from the alien structure"
	^self unsignedLongAt: 533