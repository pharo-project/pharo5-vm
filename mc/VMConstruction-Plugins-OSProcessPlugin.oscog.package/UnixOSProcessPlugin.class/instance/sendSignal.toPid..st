private - signal handers
sendSignal: sig toPid: pid
	"kill(pid, sig)"

	^ self k: pid ill: sig