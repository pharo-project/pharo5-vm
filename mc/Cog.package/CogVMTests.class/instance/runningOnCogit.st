support
runningOnCogit
	"CogVMTests new runningOnCogit"
	^(1 to: 3) anySatisfy: [:each| thisContext xrayIsExecutingMachineCode]