initialize-release
setCogSupportRequirement: aBoolean
	"If true, the image expects the virtual machine to be able to provide Cog
	support, either in the form of a Stack VM or a Cog VM. If false, the image does
	not require this support, although the virtual machine is free to provide it."

	aBoolean ifTrue: [requiresClosureSupport := true]. "required in all Cog images"
	self setNativeFloatWordOrderRequirement: aBoolean
