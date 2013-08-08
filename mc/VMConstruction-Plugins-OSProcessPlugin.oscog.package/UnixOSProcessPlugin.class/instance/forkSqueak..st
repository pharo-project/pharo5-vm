primitives - fork and exec
forkSqueak: useSignalHandler
	"Fork a child process, and continue running squeak in the child process.
	Answer the result of the fork() call, either the child pid or zero.

	After calling fork(), two OS processes exist, one of which is the child of the other. On
	systems which implement copy-on-write memory management, and which support the
	fork() system call, both processes will be running Smalltalk images, and will be sharing
	the same memory space. In the original OS process, the resulting value of pid is the
	process id of the child process (a non-zero integer). In the child process, the value of
	pid is zero.

	The child recreates sufficient external resources to continue running. This is done by
	attaching to a new X session. The child is otherwise a copy of the parent process, and
	will continue executing the Smalltalk image at the same point as its parent. The return
	value of this primitive may be used by the two running Smalltalk images to determine
	which is the parent and which is the child.

	The child should not depend on using existing connections to external resources. For
	example, the child may lose its connections to stdin, stdout, and stderr after its parent
	exits.

	The new child image does not start itself from the image in the file system; rather it is
	a clone of the parent image as it existed at the time of primitiveForkSqueak. For this
	reason, the parent and child should agree in advance as to whom is allowed to save the
	image to the file system, otherwise one Smalltalk may overwrite the image of the other.

	This is a simple call to fork(), rather than the more common idiom of vfork() followed
	by exec(). The vfork() call cannot be used here because it is designed to be followed by
	an exec(), and its semantics require the parent process to wait for the child to exit. See
	the BSD programmers documentation for details."

	| pid intervalTimer saveIntervalTimer |
	<export: true>
	<returnTypeC: 'pid_t'>
	<var: 'pid' type: 'pid_t'>
	<var: 'intervalTimer' type: 'struct itimerval'>
	<var: 'saveIntervalTimer' type: 'struct itimerval'>

	"Turn off the interval timer. If this is not done, then the program which we exec in
	the child process will receive a timer interrupt, and will not know how to handle it."
	self cCode: 'intervalTimer.it_interval.tv_sec = 0'.
	self cCode: 'intervalTimer.it_interval.tv_usec = 0'.
	self cCode: 'intervalTimer.it_value.tv_sec = 0'.
	self cCode: 'intervalTimer.it_value.tv_usec = 0'.
	self cCode: 'setitimer (ITIMER_REAL, &intervalTimer, &saveIntervalTimer)'.
	useSignalHandler ifTrue: [self setSigChldHandler].
	pid := self fork.

	"Enable the timer again before resuming Smalltalk."
	self cCode: 'setitimer (ITIMER_REAL, &saveIntervalTimer, 0L)'.
	^ pid
