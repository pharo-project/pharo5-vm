initialization
setStream: aBinaryStream
	"Initialize myself for writing on the given stream."

	stream := aBinaryStream.
	headerStart := aBinaryStream position.
