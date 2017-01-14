callout support
ffiSupportsCallingConvention: aCallingConvention
	"Check that the calling convention is valid.  This test also filters out attempts
	 to do a threaded call in the non-threaded VM/plugin combinatioin."

	<inline: true>
	^aCallingConvention = FFICallTypeCDecl or: [aCallingConvention = FFICallTypeApi]