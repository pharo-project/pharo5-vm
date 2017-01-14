testing
testPrimJPEGWriteImage

	| form bytes ws |
	form := JPEGReadWriter2 formFromStream: self formBytes readStream.
	ws := WriteStream on: ByteArray new.
	JPEGReadWriter2 putForm: form onStream: ws.
	bytes := ws contents.
	self should: self formBytes = bytes
