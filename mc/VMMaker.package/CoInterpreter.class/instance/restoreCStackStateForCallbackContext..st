callback support
restoreCStackStateForCallbackContext: vmCallbackContext
	<var: #vmCallbackContext type: #'VMCallbackContext *'>
	cogit
		setCStackPointer: vmCallbackContext savedCStackPointer;
		setCFramePointer: vmCallbackContext savedCFramePointer.
	self mem: reenterInterpreter
		cp: vmCallbackContext savedReenterInterpreter asVoidPointer
		y: (self sizeof: #'jmp_buf')