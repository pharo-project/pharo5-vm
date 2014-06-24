initialize-release
setSpurSupportRequirement: aBoolean
	"If true, the image expects the virtual machine to be able to provide support
	for the Spur object format. If false, the image does not require this support,
	although the virtual machine is free to provide it."

	requiresSpurSupport := aBoolean
