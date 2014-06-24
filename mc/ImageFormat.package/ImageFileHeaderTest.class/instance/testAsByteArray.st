testing
testAsByteArray
	"Read and write with data in all byte positions"

	| hdr ws b1 b2 |
	b1 := self sample6505HeaderData.
	hdr := ImageFileHeader readFrom: (ReadStream on: b1).
	ws := WriteStream on: ByteArray new.
	hdr writeTo: ws littleEndian: true.
	b2 := ws contents.
	self assert: hdr asByteArray = b2.