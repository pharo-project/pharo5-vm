simulation
wantsNearAddressFor: anObject
	"A hack hook to allow x64 to address CStackPointer and CFramePointer relative to VarBaseReg."
	<doNotGenerate>
	^anObject isSymbol and: ['C*Pointer' match: anObject]