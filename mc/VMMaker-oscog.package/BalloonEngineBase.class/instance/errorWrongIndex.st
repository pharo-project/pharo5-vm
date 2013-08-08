private
errorWrongIndex
	"Ignore dispatch errors when translating to C
	(since we have no entry point for #error in the VM proxy)"
	self cCode:'' inSmalltalk:[self error:'BalloonEngine: Fatal dispatch error']