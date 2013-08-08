primitives - file locking
primitiveLockFileRegion
	"Take a struct SQFile from the stack, and request a lock on the specified region.
	If the exclusive flag is true, then request an exclusive (F_WRLCK) lock on the
     file. Otherwise, request a shared (F_RDLCK) lock. Any number of Unix processes
     may hold  a read lock (shared lock) on a file region, but only one process may
     hold a write lock (exclusive lock). Answer the result of the call to fcntl().

	If length is zero, then the entire file will be locked, including region extents that
	have not yet been allocated for the file."

	| lockStruct exclusive len start sqFileOop fileNo result |
	<export: true>
	<var: 'lockStruct' declareC: 'struct flock lockStruct'>
	<var: 'fileNo' type: 'int'>
	<var: 'result' type: 'int'>

	"Get the parameters from the stack"
	exclusive := (interpreterProxy stackValue: 0) == interpreterProxy trueObject.
	len := interpreterProxy stackIntegerValue: 1.
	start := interpreterProxy stackIntegerValue: 2.
	sqFileOop := interpreterProxy stackValue: 3.
	(self isSQFileObject: sqFileOop) ifFalse: [^ interpreterProxy primitiveFail].
	fileNo := self unixFileNumber: (self fileHandleFrom: sqFileOop).

	"Set up the flock structure parameter for fcntl()"
	exclusive
		ifTrue: [self cCode: 'lockStruct.l_type = F_WRLCK']
		ifFalse: [self cCode: 'lockStruct.l_type = F_RDLCK'].
	self cCode: 'lockStruct.l_whence = SEEK_SET'.
	self cCode: 'lockStruct.l_start = start'.
	self cCode: 'lockStruct.l_len = len'.
	self cCode: 'lockStruct.l_pid = 0'.

	"Request the lock and answer the result of the fcntl call"
	result := self cCode: 'fcntl(fileNo, F_SETLK, &lockStruct)'.
	interpreterProxy pop: 5; pushInteger: result
