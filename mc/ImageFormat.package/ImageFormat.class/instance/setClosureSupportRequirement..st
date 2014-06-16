initialize-release
setClosureSupportRequirement: aBoolean
	"If true, the image expects the virtual machine to be able to provide support
	for closure bytecodes that are present in the image. If false, the image does
	not require this support, although the virtual machine is free to provide it."

	requiresClosureSupport := aBoolean
