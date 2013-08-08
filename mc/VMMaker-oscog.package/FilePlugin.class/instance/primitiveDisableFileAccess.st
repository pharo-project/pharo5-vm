security primitives
primitiveDisableFileAccess
	<export: true>
	"If the security plugin can be loaded, use it to turn off file access
	 If not, assume it's ok"
	sDFAfn ~= 0 ifTrue:
		[self cCode: '((sqInt (*)(void))sDFAfn)()']