primitives - OS process access
primitiveUnsetEnv
	"Unset an environment variable."

	"FIXME: unsetenv() is not portable. For Solaris or any other system which does not
	support unsetenv(), just comment it out in this method and rebuild the plugin."

	<export: true>
	self unsetenv: (self transientCStringFromString: (interpreterProxy stackObjectValue: 0)).
	interpreterProxy pop: 1
