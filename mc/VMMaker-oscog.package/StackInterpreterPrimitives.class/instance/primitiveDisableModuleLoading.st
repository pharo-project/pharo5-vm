plugin primitives
primitiveDisableModuleLoading
	"Primitive. Disable a new module loading mechanism for the rest of current session.
	Any subsequent attempts to load either external or internal module(s) will fail"
	<export: true>

	self ioDisableModuleLoading.