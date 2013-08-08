other
closeFile
	"Close my stream, if it responds to close."

	stream ifNotNil: [
		(stream respondsTo: #close) ifTrue: [stream close]].
	mixer := nil.
	codec := nil.
