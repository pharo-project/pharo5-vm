as yet unclassified
internalPopStackNativeSize: popSize
	<option: #LowcodeVM>
	"In the StackInterpreter stacks grow down."
	nativeSP := self nativeStackPointerIn: localFP.
	nativeSP := self nativeStackPointerIn: localFP put: nativeSP + popSize.