wav reading
readWaveChunk: chunkType inRIFF: stream
	"Search the stream for a format chunk of the given type and return its contents."

	| id count |
	stream reset; binary.
	stream skip: 8.  "skip 'RIFF' and total length"
	id := (stream next: 4) asString.  "contents type"
	id = 'WAVE' ifFalse: [^ ''].     "content type must be WAVE"

	"search for a chunk of the given type"
	[id := (stream next: 4) asString.
	 count := self next32BitWord: false from: stream.
	 id = chunkType] whileFalse: [
		"skip this chunk, rounding length up to a word boundary"
		stream skip: (count + 1 bitAnd: 16rFFFFFFFE).
		stream atEnd ifTrue: [^ '']].

	^ stream next: count  "return raw chunk data"
