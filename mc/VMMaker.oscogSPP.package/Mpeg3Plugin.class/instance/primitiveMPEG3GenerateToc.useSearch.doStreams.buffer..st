primitives
primitiveMPEG3GenerateToc: fileHandle useSearch: timecode doStreams: streams buffer: aString
	| file bufferSize |

	"int mpeg3_generate_toc_for_Squeak(FILE *output, char *path, int timecode_search, int print_streams, char *buffer)"
	<var: #file type: 'mpeg3_t * '>
	self primitive: 'primitiveMPEG3GenerateToc'
		parameters: #(Oop SmallInteger Boolean  String).
	file := self mpeg3tValueOf: fileHandle.
	file = nil ifTrue: [^nil].
	bufferSize := interpreterProxy slotSizeOf: (interpreterProxy stackValue: 0).
	self cCode: 'mpeg3_generate_toc_for_Squeak(file,timecode,streams,aString,bufferSize)'.
