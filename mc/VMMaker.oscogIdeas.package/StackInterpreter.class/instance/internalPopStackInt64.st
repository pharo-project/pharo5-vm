internal interpreter access
internalPopStackInt64
	<option: #LowcodeVM>
	<returnTypeC: #sqLong>
	<var: #topInt64 type: #sqLong>
	"In the StackInterpreter stacks grow down."
	| topInt64 |
	nativeSP := self nativeStackPointerIn: localFP.
	topInt64 := stackPages long64AtPointer: nativeSP - 1.
	nativeSP := self nativeStackPointerIn: localFP put: nativeSP + 8.
	^topInt64