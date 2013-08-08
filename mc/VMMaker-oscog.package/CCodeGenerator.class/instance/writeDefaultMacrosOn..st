public
writeDefaultMacrosOn: aStream
	"Write macros to provide default implementations of certain functions used by
	the interpreter. If not previously defined in config.h they will be defined here.
	The definitions will be available to any module that includes sqMemoryAccess.h.
	The default macros are chosen for backward compatibility with existing platform
	support code."

	aStream cr;
		nextPutAll: '#ifndef allocateMemoryMinimumImageFileHeaderSize'; cr;
		nextPutAll: ' /* Called by Interpreter>>allocateMemory:minimum:imageFile:headerSize: */'; cr;
		nextPutAll: ' #define allocateMemoryMinimumImageFileHeaderSize(',
						'heapSize, minimumMemory, fileStream, headerSize) \'; cr;
		nextPutAll: '    sqAllocateMemory(minimumMemory, heapSize)'; cr;
		nextPutAll: '#endif'; cr; cr;
		nextPutAll: '#ifndef sqImageFileReadEntireImage'; cr;
		nextPutAll: ' /* Called by Interpreter>>sqImage:read:size:length: */'; cr;
		nextPutAll: ' #define sqImageFileReadEntireImage(memoryAddress, fileStream, ',
						'elementSize,  length) \'; cr;
		nextPutAll: '    sqImageFileRead(memoryAddress, fileStream, elementSize,  length)'; cr;
		nextPutAll: '#endif'; cr; cr
