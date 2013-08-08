initialization
initStream: aStream headerStart: anInteger
	"Initialize for streaming from the given stream. The audio file header starts at the given stream position."

	stream := aStream.
	volume := 1.0.
	repeat := false.
	headerStart := anInteger.
	self reset.
