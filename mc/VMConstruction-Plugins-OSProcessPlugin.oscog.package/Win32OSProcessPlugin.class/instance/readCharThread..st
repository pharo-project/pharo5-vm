private - nonblocking read thread
readCharThread: args
	"This is the entry point for the thread procedure for reading one character from
	a file or pipe handle. There may be many instances of this thread procedure, in
	which case each thread may be distinguished by the index value with which it is
	called. Remember the index value by saving it in a variable on the thread stack.
	Read one character, and signal a Smalltalk Semaphore to indicate completion."

	| index handle threadArgs |
	<returnTypeC: 'DWORD WINAPI'>
	<var: 'handle' type: 'HANDLE'>
	<var: 'args' type: 'void *'>
	<var: 'threadArgs' type: 'struct {int index; HANDLE handle;} *'>
	threadArgs := args.
	self cCode: 'index = threadArgs->index'.
	self cCode: 'handle = threadArgs->handle'.
	"Save arguments in stack local variables. The mutex semaphore will be
	released as soon as these variables are safely on a local thread stack."
	^ self readCharThreadIndex: index handle: handle
