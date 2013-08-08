private - VM atexit
sendSignalToPids
	"Exit function to be registered with atexit() to signal child processes on VM exit."

	| count pid |
	<returnTypeC: 'void'>
	<var: 'pid' type: 'pid_t'>
	count := 0.
	[count < pidCount]
		whileTrue: [pid := pidArray at: count.
			self sendSignal: sigNumToSend toPid: pid.
			count := count + 1]