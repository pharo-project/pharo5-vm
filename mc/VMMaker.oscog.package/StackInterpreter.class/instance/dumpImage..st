image save/restore
dumpImage: fileName
	"Dump the entire image out to the given file. Intended for debugging only.  Doesn't work for Spur."
	| f dataSize result |
	<notOption: #SpurObjectMemory>
	<export: true>
	<var: #f type: #sqImageFile>

	f := self sqImageFile: (self pointerForOop: fileName) Open: 'wb'.
	f = nil ifTrue: [^-1].
	dataSize := objectMemory endOfMemory - objectMemory startOfMemory.
	result := self sq: (self pointerForOop: self memory) Image: (self sizeof: #'unsigned char') File: dataSize Write: f.
	self sqImageFileClose: f.
	^result