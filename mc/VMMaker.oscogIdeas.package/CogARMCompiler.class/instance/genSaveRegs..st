abi
genSaveRegs: regMask
	"Save the registers in regMask for a call into the C run-time from a trampoline"
	<inline: true>
	^self genPushRegisterMask: regMask