security primitives
primitiveDisableSocketAccess
	<export: true>
	"If the security plugin can be loaded, use it to turn off socket access
	 If not, assume it's ok"
	sDSAfn ~= 0 ifTrue:
		[self cCode: '((sqInt (*) (void)) sDSAfn)()']