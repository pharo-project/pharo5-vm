primitives - file locking
primitiveTestLockableFileRegion
	"Take a struct SQFile from the stack, and check for ability to lock the specified region.
	If the exclusive flag is true, then specify an exclusive (F_WRLCK) lock on the
     file. Otherwise, specify a shared (F_RDLCK) lock. Any number of Unix processes
     may hold  a read lock (shared lock) on a file region, but only one process may
     hold a write lock (exclusive lock).

	If length is zero, then the request is for the entire file to be locked, including
	region extents that have not yet been allocated for the file.

	If the fcntl() call fails, answer -1 (the result of the failed call). Otherwise,
	answer an array with the following six fields:
		lockable (true or false)
		l_pid (pid of the process preventing this lock request, or nil)
		l_type (request type F_WRLCK or F_RDLOCK of the process preventing this lock request)
		l_whence (the SEEK_SET, SEEK_CUR, or SEEK_END value of the lock preventing this lock request).
		l_start (offset of the region lock preventing this lock request)
		l_len (length of the region lock preventing this lock request)"

	| lockStruct exclusive len start sqFileOop fileNo result resultArray canObtainLock |
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

	"Check availability of the lock"
	result := self cCode: 'fcntl(fileNo, F_GETLK, &lockStruct)'.
	(result == -1)
		ifTrue:
			[interpreterProxy pop: 5; pushInteger: result]
		ifFalse:
			[(self cCode: 'lockStruct.l_type == F_UNLCK')
				ifTrue: [canObtainLock := interpreterProxy trueObject]
				ifFalse: [canObtainLock := interpreterProxy falseObject].
			
resultArray := interpreterProxy
							instantiateClass: (interpreterProxy classArray)
							indexableSize: 6.
			interpreterProxy
				stObject: resultArray
				at: 1
				put: canObtainLock.
			interpreterProxy
				stObject: resultArray
				at: 2
				put: (interpreterProxy integerObjectOf: (self cCode: 'lockStruct.l_pid')).
			interpreterProxy
				stObject: resultArray
				at: 3
				put: (interpreterProxy integerObjectOf: (self cCode: 'lockStruct.l_type')).
			interpreterProxy
				stObject: resultArray
				at: 4
				put: (interpreterProxy integerObjectOf: (self cCode: 'lockStruct.l_whence')).
			interpreterProxy
				stObject: resultArray
				at: 5
				put: (interpreterProxy integerObjectOf: (self cCode: 'lockStruct.l_start')).
			interpreterProxy
				stObject: resultArray
				at: 6
				put: (interpreterProxy integerObjectOf: (self cCode: 'lockStruct.l_len')).
			interpreterProxy pop: 5 thenPush: resultArray]
