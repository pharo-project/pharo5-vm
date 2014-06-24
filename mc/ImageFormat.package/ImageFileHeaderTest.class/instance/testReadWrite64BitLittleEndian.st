testing
testReadWrite64BitLittleEndian
	"Read and write with data in all byte positions"

	| hdr ws b1 b2 |
	b1 := ByteArray new: 128.
	#[162 9 1 0 0 0 0 0 128 0 0 0 0 0 0 0] withIndexDo: [ :e :i | b1 at: i put: e].
	17 to: 128 do: [ :i | b1 at: i put: i ].
	hdr := ImageFileHeader readFrom: (ReadStream on: b1).
	ws := WriteStream on: ByteArray new.
	hdr writeTo: ws littleEndian: true.
	b2 := ws contents.
	self assert: (b2 first: 72) = (b1 first: 72).
	self assert: (b2 last: (128 - 72)) asSet size = 1. "all zeros"