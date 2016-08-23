process primitives
primitiveVMCurrentThreadId
	<export: true>
	"Answer the VM's current thread's Id"
	self cCode: [] inSmalltalk: [cogThreadManager isNil ifTrue: [^self primitiveFail]].
	self pop: 1 thenPushInteger: cogThreadManager getVMOwner