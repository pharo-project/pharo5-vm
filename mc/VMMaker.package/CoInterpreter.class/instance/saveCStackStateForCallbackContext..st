callback support
saveCStackStateForCallbackContext: vmCallbackContext
	<var: #vmCallbackContext type: #'VMCallbackContext *'>
	vmCallbackContext
		savedCStackPointer: cogit getCStackPointer;
		savedCFramePointer: cogit getCFramePointer.
	self mem: vmCallbackContext savedReenterInterpreter asVoidPointer
		cp: reenterInterpreter
		y: (self sizeof: #'jmp_buf')