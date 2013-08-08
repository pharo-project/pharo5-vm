class initialization
ensureNotifiedAtStartup
	"FFICallbackThunk needs to be notified at system startup to clear the ExecutablePages table."
	self ~~ FFICallbackThunk ifTrue: [^self].
	self ensureNotifiedAtStartupAfter: Alien