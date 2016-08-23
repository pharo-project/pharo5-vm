debug support
assertSaneThreadAndProcess
	<inline: true>
	self assert: cogThreadManager getVMOwner > 0.
	self assert: cogThreadManager currentVMThread state = CTMAssignableOrInVM.
	self assert: (objectMemory fetchPointer: MyListIndex ofObject: self activeProcess) = objectMemory nilObject