internal interpreter access
internalPopStackFloat32
	<option: #LowcodeVM>
	<returnTypeC: #float>
	<var: #topSingle type: #float>
	"In the StackInterpreter stacks grow down."
	| topSingle  |
	nativeSP := self nativeStackPointerIn: localFP.
	topSingle := stackPages singleFloatAtPointer: nativeSP - 1.
	nativeSP := self nativeStackPointerIn: localFP put: nativeSP + 4.
	^topSingle