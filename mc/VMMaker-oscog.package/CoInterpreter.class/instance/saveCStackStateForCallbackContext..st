callback support
saveCStackStateForCallbackContext: vmCallbackContext
	<var: #vmCallbackContext type: #'VMCallbackContext *'>
	vmCallbackContext
		savedCStackPointer: cogit getCStackPointer;
		savedCFramePointer: cogit getCFramePointer.
	self mem: (self cCoerceSimple: vmCallbackContext savedReenterInterpreter to: #'void *')
		cp: reenterInterpreter
		y: (self sizeof: #'jmp_buf')