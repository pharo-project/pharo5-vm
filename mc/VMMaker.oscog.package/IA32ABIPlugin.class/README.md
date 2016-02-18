This plugin implements the Alien foreign-function interface, a small elaboration on the Strongtalk FFI.

Call-outs are performed by a small number of primitives, one each for the four different kinds of return linkage on x86.  The primitives are var-args.  Each primitive has a signature something like:
primFFICall: functionAddress <Alien> result: result <Alien> with: firstArg <Alien> ... with: lastArg <Alien>
	<primitive: 'primCallOutIntegralReturn' module: 'IA32ABI'>
which arranges to call-out supplying the arguments to the function pointed to by functionAddress, copying its return value into result.  The call-out primitives are as follows:

primCallOutIntegralReturn call a function which returns up to 8 bytes in %eax & %edx, taking up to the first 4 bytes from %eax.  i.e. if the sizeof(result) is 4 or less only bytes from %eax will be returned, but if more then the first 4 bytes of result will be assigned with %eax and subsequent bytes with %edx, up to a total of 8 bytes.

primCallOutPointerReturn call a function which returns a pointer in %eax.  Assign sizeof(result) bytes from this pointer into the result.

primCallOutFloatReturn call a function which returns a 4 byte single-precision float in %f0, assigning the 4 bytes of %f0 into result.

primCallOutDoubleReturn call a function which returns an 8 byte double-precision float in %f0, assigning the 8 bytes of %f0 into result.

