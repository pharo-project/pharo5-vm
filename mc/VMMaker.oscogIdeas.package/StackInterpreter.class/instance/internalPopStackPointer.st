internal interpreter access
internalPopStackPointer
	<option: #LowcodeVM>
	<returnTypeC: #'char*'>
	<var: #topPointer type: #'char*'>
	"In the StackInterpreter stacks grow down."
	| topPointer |
	nativeSP := self nativeStackPointerIn: localFP.
	topPointer := stackPages pointerAtPointer: nativeSP - 1.
	nativeSP := self nativeStackPointerIn: localFP put: nativeSP + objectMemory bytesPerOop.
	^topPointer