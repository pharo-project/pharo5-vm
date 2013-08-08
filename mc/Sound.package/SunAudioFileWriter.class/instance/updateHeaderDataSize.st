other
updateHeaderDataSize
	"Update the Sun audio file header to reflect the final size of the sound data."

	| byteCount |
	byteCount := stream position - (headerStart + 24).
	stream position: headerStart + 8.
	stream uint32: byteCount.
