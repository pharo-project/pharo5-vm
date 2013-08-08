other
ensureOpen
	"Ensure that my stream is open."

	stream closed ifTrue: [stream reopen; binary].
