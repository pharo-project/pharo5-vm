primitives - OS process access
primitiveSetSid
	"Quoted from Linux man pages:
	setsid() creates a new session if the calling process is not a process group leader.
	The calling process is the leader of the new session, the process  group  leader  of
	the new process group, and has no controlling tty.  The process group ID and session
	ID of the calling process are set to the PID of the calling  process.   The  calling
	process  will be the only process in this new process group and in this new session."

	| sessionId |
	<export: true>
	<var: 'sessionId' type: 'pid_t'>
	sessionId := self setsid.
	sessionId == -1 ifTrue: [^ interpreterProxy primitiveFail].
	interpreterProxy pop: 1; pushInteger: sessionId
