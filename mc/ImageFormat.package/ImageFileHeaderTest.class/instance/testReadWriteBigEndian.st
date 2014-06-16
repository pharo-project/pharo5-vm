testing
testReadWriteBigEndian
	"Read and write with data in all byte positions"

	| hdr ws b1 b2 |
	b1 := ByteArray new: 64.
	b1 at: 4 put: 104; at: 3 put: 25; at: 2 put: 0; at: 1 put: 0. "a valid image format number"
	b1 at: 8 put: 64; at: 7 put: 0; at: 6 put: 0; at: 5 put: 0. "header size 64"
	9 to: 64 do: [ :i | b1 at: i put: i ].
	hdr := ImageFileHeader readFrom: (ReadStream on: b1).
	ws := WriteStream on: ByteArray new.
	hdr writeTo: ws littleEndian: false.
	b2 := ws contents.
	self assert: (b2 first: 36) = (b1 first: 36).
	self assert: (b2 last: (64 - 36)) asSet size = 1. "all zeros"