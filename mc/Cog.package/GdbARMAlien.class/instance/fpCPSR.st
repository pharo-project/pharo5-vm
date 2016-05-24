accessing
fpCPSR
"The VFP cpsr flags are kept as a single word in the Alien structure. Return just the top 4 bits, the actual flags"
	^(self unsignedLongAt: 1789) >>28