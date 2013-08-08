callback support
restoreCStackStateForCallbackContext: vmCallbackContext
	<var: #vmCallbackContext type: #'VMCallbackContext *'>
	cogit
		setCStackPointer: vmCallbackContext savedCStackPointer;
		setCFramePointer: vmCallbackContext savedCFramePointer.
	self mem: reenterInterpreter
		cp: (self cCoerceSimple: vmCallbackContext savedReenterInterpreter to: #'void *')
		y: (self sizeof: #'jmp_buf')