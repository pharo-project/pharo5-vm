primitives - VM atexit
primitiveKillOnExit
	"Set a list of pids to kill with signum when VM exits. If the signum
	parameter is nil, the default value of SIGTERM will be used."

	| pids signum pidPointer count p pid |
	<export: true>
	<var: 'pidPointer' type: 'sqInt *'>
	<var: 'p' type: 'pid_t *'>
	<var: 'pid' type: 'pid_t'>
	pids := interpreterProxy stackValue: 1.
	signum := interpreterProxy stackValue: 0.
	pidCount := interpreterProxy stSizeOf: pids.
	interpreterProxy failed ifTrue: [^ nil].
	pidArray == 0 ifFalse: [self free: pidArray].
	pidArray := self cCode: 'malloc(pidCount * sizeof(pid_t))'.
	pidArray == 0
		ifTrue: [pidCount := 0.
			^ interpreterProxy primitiveFail].
	"Copy pid values into externally allocated array"
	pidPointer := interpreterProxy firstIndexableField: pids.
	count := 0.
	p := pidArray.
	[count <= pidCount]
		whileTrue: [pid := interpreterProxy
						integerValueOf: (self cCode: '*pidPointer++').
			self cCode: '*p++ = pid'.
			count := count + 1].
	signum == interpreterProxy nilObject
		ifFalse: [sigNumToSend := interpreterProxy checkedIntegerValueOf: signum].
	interpreterProxy failed
		ifTrue: [pidCount := 0].
	interpreterProxy pop: 2