testing
testReadWrite64BitCogBigEndian
	"Read and write with data in all byte positions"

	| hdr ws b1 b2 |
	b1 := ByteArray new: 128.
	#[0 0 0 0 0 1 9 162 0 0 0 0 0 0 0 128] withIndexDo: [ :e :i | b1 at: i put: e].
	17 to: 128 do: [ :i | b1 at: i put: i ].
	hdr := CogImageFileHeader readFrom: (ReadStream on: b1).
	ws := WriteStream on: ByteArray new.
	hdr writeTo: ws littleEndian: false.
	b2 := ws contents.
	self assert: (b2 first: 92) = (b1 first: 92).
	self assert: (b2 last: (128 - 92)) asSet size = 1. "all zeros"