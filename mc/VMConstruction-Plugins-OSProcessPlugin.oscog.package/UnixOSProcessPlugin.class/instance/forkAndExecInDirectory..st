primitives - fork and exec
forkAndExecInDirectory: useSignalHandler
	"Fork a child OS process, and do an exec in the child. The parent continues on in
	Smalltalk, and this method answers the pid of the child which was created. If
	useSignalHandler is true, set the signal handler for SIGCHLD. Otherwise, assume
	that death of child events are handled through some other mechanism.

	In this implementation, memory for the argument and environment arrays is allocated
	in the image prior to calling this primitive. This allows us to avoid invoking the
	garbage collector in this primitive (thereby moving the locations of environment
	and argument memory), but comes at the cost of twiddling C pointers here in the
	primitive. An alternative to this whole mess is just to malloc the environment and
	argument vectors, but I think it is a good idea to avoid malloc as much as possible
	so as not to limit future ObjectMemory implementations.

	This primitive replaces #primitiveForkAndExec from earlier versions of the plugin.
	The new name permits backward compatibility for an image running on a VM
	which does not yet have the updated plugin. This implementation uses a different
	argument format on the stack, and differs functionally in that the child now closes
	all file descriptors (including sockets) not required (that is, everything except stdin,
	stdout, and stderr on descriptors 0, 1 and 2). This eliminates some flakey behavior
	in child processes connected to Squeak by pipes, which failed to exit at expected times
	due to the old file descriptors remaining open. This is also cleaner in that garbage
	descriptors are not left hanging around the the child.

	On entry, the stack contains:
		0: workingDir, a null terminated string specifying the working directory to use, or nil.
		1: envOffsets, an array of integers for calculating environment string address offsets.
		2: envVecBuffer, a String buffer containing environment strings arranged to look like char **.
		3: argOffsets, an array of integers for calculating argument string address offsets.
		4: argVecBuffer, a String buffer containing argument strings arranged to look like char **.
		5: stdErr, a ByteArray handle.
		6: stdOut, a ByteArray handle.
		7: stdIn, a ByteArray handle.
		8: executableFile, a null terminated string with the name of the file to execute.
		9: the sender"

	| progNamePtr argsPtr envPtr intervalTimer saveIntervalTimer envVec pid
	envOffsets envVecBuffer argOffsets argVecBuffer stdErr stdOut stdIn executableFile idx
	handleCount envCount argCount envOffsetPtr argOffsetPtr workingDir pwdPtr pwd env args |
	<var: 'progNamePtr' declareC: 'char *progNamePtr'>
	<var: 'argsPtr' declareC: 'char *argsPtr'>
	<var: 'envPtr' declareC: 'char *envPtr'>
	<var: 'args' declareC: 'char **args'>
	<var: 'env' declareC: 'char **env'>
	<var: 'pwdPtr' declareC: 'char *pwdPtr'>
	<var: 'intervalTimer' type: 'struct itimerval'>
	<var: 'saveIntervalTimer' type: 'struct itimerval'>
	<var: 'envVec' declareC: 'extern char **envVec'>
	<var: 'pid' type: 'pid_t'>
	<var: 'envOffsetPtr' declareC: 'sqInt *envOffsetPtr'>
	<var: 'argOffsetPtr' declareC: 'sqInt *argOffsetPtr'>

	useSignalHandler ifTrue: [self setSigChldHandler].

	"Do not fork child if running in secure mode"
	(self sandboxSecurity == 1) ifTrue: [interpreterProxy pop: 10; pushInteger: -1] ifFalse: [

	"Turn off the interval timer. If this is not done, then the program which we exec in
	the child process will receive a timer interrupt, and will not know how to handle it."
	self cCode: 'intervalTimer.it_interval.tv_sec = 0'.
	self cCode: 'intervalTimer.it_interval.tv_usec = 0'.
	self cCode: 'intervalTimer.it_value.tv_sec = 0'.
	self cCode: 'intervalTimer.it_value.tv_usec = 0'.
	self cCode: 'setitimer (ITIMER_REAL, &intervalTimer, &saveIntervalTimer)'.

	((pid := self cCode: 'vfork()') = 0)
		ifFalse:
			[ "Normal return to Smalltalk - this is the old parent process."
			"Enable the timer again before resuming Smalltalk."
			self cCode: 'setitimer (ITIMER_REAL, &saveIntervalTimer, 0L)'.
			interpreterProxy pop: 10; pushInteger: pid 
			"Pop 9 arguments plus receiver, push pid."]
		ifTrue:
			[ "This is the new child process"
			workingDir := interpreterProxy stackObjectValue: 0.
			envOffsets := interpreterProxy stackObjectValue: 1.
			envVecBuffer := interpreterProxy stackObjectValue: 2.
			argOffsets := interpreterProxy stackObjectValue: 3.
			argVecBuffer := interpreterProxy stackObjectValue: 4.
			stdErr := interpreterProxy stackObjectValue: 5.
			stdOut := interpreterProxy stackObjectValue: 6.
			stdIn := interpreterProxy stackObjectValue: 7.
			executableFile := interpreterProxy stackObjectValue: 8.

			"If a new working directory has been specified, try to chdir() to it."
			(workingDir ~= interpreterProxy nilObject)
				ifTrue:
					[pwdPtr := interpreterProxy firstIndexableField: workingDir.
					(pwdPtr == 0)
						ifTrue:
							[self cCode: 'fprintf(stderr, "bad workingDir parameter\n")'.
							self cCode: '_exit(-1)']
						ifFalse:
							[pwd := self cCode: 'chdir(pwdPtr)' inSmalltalk: [0].
							(pwd ~= 0)
								ifTrue:
									[self cCode: 'perror("chdir")'.
									self cCode: '_exit(-1)']]].

			"Pointer to name of the file to execute."
			progNamePtr := interpreterProxy arrayValueOf: executableFile.

			"Dup the file handles to attach the new child process to the right streams
			on descriptors 0, 1 and 2."
			(stdErr = interpreterProxy nilObject) ifFalse: [self dupToStdErr: stdErr].
			(stdOut = interpreterProxy nilObject) ifFalse: [self dupToStdOut: stdOut].
			(stdIn = interpreterProxy nilObject) ifFalse: [self dupToStdIn: stdIn].

			"Close all file handles not needed by the child. This is done by brute force
			because the image has no way of being aware of all open file descriptors
			(some are opened by the VM without the knowledge of the image)."
			idx := 3.	"First Unix file descriptor after stdin, stdout, stderr."
			handleCount := self descriptorTableSize.
			[idx < handleCount]
				whileTrue:
					[self cCode: 'close(idx)'.
					idx := idx + 1].

			"Set up the environment, a C array of pointers to C strings, where each string
			is of the form 'KEY=value'. Refer to previously allocated object memory rather
			than using a call to malloc()."
			envVecBuffer = (interpreterProxy nilObject)
				ifTrue:
					[env := envVec]
				ifFalse:
					[envCount := interpreterProxy stSizeOf: envOffsets.
					envPtr := interpreterProxy arrayValueOf: envVecBuffer.
					envOffsetPtr := interpreterProxy firstIndexableField: envOffsets.
					self
						fixPointersInArrayOfStrings: envPtr
						withOffsets: envOffsetPtr
						count: envCount.
					env := self cCoerce: envPtr to: 'char **'].

			"Set up the argument array. Allocate space for a C array of pointers to strings.
			Reer to previously allocated object memory rather than using a call to malloc()."
			argCount := interpreterProxy stSizeOf: argOffsets.
			argsPtr := interpreterProxy arrayValueOf: argVecBuffer.
			argOffsetPtr := interpreterProxy firstIndexableField: argOffsets.
			self
				fixPointersInArrayOfStrings: argsPtr
				withOffsets: argOffsetPtr
				count: argCount.
			args := self cCoerce: argsPtr to: 'char **'.

			"Clean things up before clobbering the running image."
			"Note: If any file descriptors, signal handlers, or other references to external
			resources need to be cleaned up, do it here."
			self restoreDefaultSignalHandlers.

			"Do the exec to overlay the new program on this child address space. This is 
			the end of the world as we know it."
			(self cCode: 'execve(progNamePtr, args, env)' ) = -1
				ifTrue:
					[self cCode: 'perror(progNamePtr)'; cCode: '_exit(-1)' "execve() error, child exits"]
				ifFalse:
					[self cCode: '/* Can''t get here from there */']]]
