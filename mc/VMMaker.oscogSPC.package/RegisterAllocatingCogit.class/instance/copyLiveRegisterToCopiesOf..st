bytecode generator support
copyLiveRegisterToCopiesOf: simStackEntry
	"Copy the liveRegister in simStackEntry into all corresponding stack entries."
	<var: #simStackEntry type: #'SimStackEntry *'>
	simStackPtr to: 0 by: -1 do:
		[:i|
		(self simStackAt: i) copyLiveRegisterIfSameAs: simStackEntry]