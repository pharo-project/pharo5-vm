public
storeHeaderOnFile: fileName bytesPerWord: bytesPerWord
	"Store C header code for this interpreter on the given file."

	| aStream |
	aStream := VMMaker forceNewFileNamed: fileName.
	aStream ifNil: [Error signal: 'Could not open C header file: ', fileName].
	aStream
		nextPutAll: '/* ';
		nextPutAll: VMMaker headerNotice;
		nextPutAll: ' */'; cr; cr.
	self writeDefineBytesPerWord: bytesPerWord on: aStream.
	self writeDefineMemoryAccessInImageOn: aStream.
	self writeDefaultMacrosOn: aStream.
	aStream close