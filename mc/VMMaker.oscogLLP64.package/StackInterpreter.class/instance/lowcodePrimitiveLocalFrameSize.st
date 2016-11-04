inline primitive generated code
lowcodePrimitiveLocalFrameSize
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| size |
	size := extA.

	"Mark the frame"
	self setFrameHasNativeFrame: localFP.
	"Store the previous stack pointer"
	self nativePreviousStackPointerIn: localFP put: nativeStackPointer + 1.
	"Make the frame pointer"
	nativeStackPointer := nativeStackPointer - size.
	self nativeFramePointerIn: localFP put: nativeStackPointer + 1.
	"Set the stack pointer"
	nativeSP := nativeStackPointer + 1.
	self nativeStackPointerIn: localFP put: nativeStackPointer + 1.
	"Reserve space for the native stack"
	nativeStackPointer := nativeStackPointer - self defaultNativeStackFrameSize.

	extA := 0.

