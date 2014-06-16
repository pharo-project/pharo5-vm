testing
testSample68002Header
	"Using data from a real file header, verify conversions"

	| hdr ws b1 b2 |
	b1 := self sample68002HeaderData.
	hdr := ImageFileHeader readFrom: (ReadStream on: b1).
	ws := WriteStream on: ByteArray new.
	hdr writeTo: ws littleEndian: true.
	b2 := ws contents.
	self assert: b2 = (b1 first: 128).