internal interpreter access
internalPopStackFloat64
	<option: #LowcodeVM>
	<returnTypeC: #double>
	<var: #topDouble type: #double>
	"In the StackInterpreter stacks grow down."
	| topDouble |
	nativeSP := self nativeStackPointerIn: localFP.
	topDouble := stackPages floatAtPointer: nativeSP - 1.
	nativeSP := self nativeStackPointerIn: localFP put: nativeSP + 8.
	^topDouble