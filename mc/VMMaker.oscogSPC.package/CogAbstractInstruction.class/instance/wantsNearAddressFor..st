simulation
wantsNearAddressFor: anObject
	"A hack hook to allow ARM to override the simulated address for the short-cut trampolines,
	 and to allow x64 to address CStackPointer and CFramePointer relative to VarBaseReg."
	^false