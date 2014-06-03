documentation
notes
	"win32: When a thread terminates, the thread object attains a signaled state, satisfying any threads that were waiting on the object.

	if (WaitForSingleObject( hThread, 0) == WAIT_OBJECT_0) {
		// the thread handle is signaled - the thread has terminated
	}
	else {
		// the thread handle is not signaled - the thread is still alive
	}

	Alternatively use BOOL WINAPI GetExitCodeThread(HANDLE hThread, LPDWORD lpExitCode)
	which returns STILL_ACTIVE if still active.

	DWORD retval;

	if (GetExitCodeThread( hThread, &retval) == STILL_ACTIVE) {
		// the thread is still alive
	}
	else {
		// the thread has terminated
	}

	pthreads:
		The pthread_kill() function sends a signal, specified by sig, to a
		thread, specified by thread.  If sig is 0, error checking is performed,
		but no signal is actually sent.

		pthread_kill() will fail if:
			[ESRCH]		thread is an invalid thread ID.

	if (pthread_kill(thread, 0) == ESRCH) {
		// the thread can't be found and has teminated
	}
	else {
		// the thread can be found and has either not terminated or the handle has been reused
	}"