accessing
constantNativePointer
	"Answer the value of constant native pointer"
	self assert: type = SSConstantNativePointer.
	^constantNativePointer