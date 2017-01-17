primitives
primitiveMPEG3ReadFrame: fileHandle buffer: aBuffer x: xNumber y: yNumber w: width h: height ow: outWidth oh: outHeight colorModel: model stream: aNumber bytesPerRow: aByteNumber 
	| file result outputRowsPtr bufferBaseAddr |
	<var: #file type: 'mpeg3_t * '>
	<var: #bufferBaseAddr type: 'unsigned char *'>
	<var: #outputRowsPtr type: 'unsigned char  ** '>

	"int mpeg3_read_frame(mpeg3_t *file, 
		unsigned char **output_rows, 
		int in_x, 
		int in_y, 
		int in_w, 
		int in_h, 
		int out_w, 
		int out_h, 
		int color_model,
		int stream)"

	self primitive: 'primitiveMPEG3ReadFrame'
		parameters: #(Oop WordArray  SmallInteger  SmallInteger  SmallInteger  SmallInteger  SmallInteger  SmallInteger  SmallInteger  SmallInteger SmallInteger).

	file := self mpeg3tValueOf: fileHandle.
	file = nil ifTrue: [^0].
	aNumber < 0 ifTrue: [ interpreterProxy success: false.  ^nil ].
	aNumber >= (self cCode: 'result = mpeg3_total_vstreams(file)') ifTrue: [
		interpreterProxy success: false.  ^0 ].

	bufferBaseAddr := self cCoerce: aBuffer to: 'unsigned char *'.
	self cCode: 'outputRowsPtr = (unsigned char **) memoryAllocate(1,sizeof(unsigned char*) * outHeight)'.

	0 to: outHeight-1 do: [:i | outputRowsPtr at: i put: (bufferBaseAddr + (aByteNumber*i))].
		
	self cCode: 'result = mpeg3_read_frame(file,outputRowsPtr,xNumber,yNumber,width,height,outWidth,outHeight,model,aNumber)'.
	self cCode: 'memoryFree(outputRowsPtr)'.
	^result asSmallIntegerObj
