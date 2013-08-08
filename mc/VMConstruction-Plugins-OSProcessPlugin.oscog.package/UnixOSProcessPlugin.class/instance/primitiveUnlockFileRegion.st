primitives - file locking
primitiveUnlockFileRegion
	"Take a struct SQFile from the stack, and unlock the specified region.
	Answer the result of the call to fcntl(). If the region is in the file lock cache,
	remove it, but otherwise ignore the cache. The cache supports Win32 semantics
	within a single Squeak image, but not across separate images, therefore the
	unlock should be attempted regardless of whether this image thinks that the
	region has previously been locked. Answer the result of the call to fcntl()."

	| lockStruct len start sqFileOop fileNo result |
	<export: true>
	<var: 'lockStruct' declareC: 'struct flock lockStruct'>
	<var: 'fileNo' type: 'int'>
	<var: 'result' type: 'int'>

	"Get the parameters from the stack"
	len := interpreterProxy stackIntegerValue: 0.
	start := interpreterProxy stackIntegerValue: 1.
	sqFileOop := interpreterProxy stackValue: 2.
	(self isSQFileObject: sqFileOop) ifFalse: [^ interpreterProxy primitiveFail].
	fileNo := self unixFileNumber: (self fileHandleFrom: sqFileOop).

	"Set up the flock structure parameter for fcntl()"
	self cCode: 'lockStruct.l_type = F_UNLCK'.
	self cCode: 'lockStruct.l_whence = SEEK_SET'.
	self cCode: 'lockStruct.l_start = start'.
	self cCode: 'lockStruct.l_len = len'.
	self cCode: 'lockStruct.l_pid = 0'.

	"Request the lock and answer the result of the fcntl call"
	result := self cCode: 'fcntl(fileNo, F_SETLK, &lockStruct)'.
	interpreterProxy pop: 4; pushInteger: result
