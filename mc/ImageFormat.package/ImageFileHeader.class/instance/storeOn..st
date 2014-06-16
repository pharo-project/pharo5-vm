printing
storeOn: aStream 
	"Append to the argument aStream a sequence of characters that is an 
	expression whose evaluation creates an object similar to the receiver."

	aStream nextPutAll: self class name;
		nextPutAll: ' new imageFormat: ('.
	imageFormat storeOn: aStream.

	aStream nextPutAll: '); headerSize: '.
	headerSize storeOn: aStream.

	aStream nextPutAll: '; imageBytes: '.
	imageBytes storeOn: aStream.

	aStream nextPutAll: '; startOfMemory: '.
	startOfMemory storeOn: aStream.

	aStream nextPutAll: '; specialObjectsOop: '.
	specialObjectsOop storeOn: aStream.

	aStream nextPutAll: '; lastHash: '.
	lastHash storeOn: aStream.
	
	aStream nextPutAll: '; screenSize: '.
	screenSize storeOn: aStream.
	
	aStream nextPutAll: '; imageHeaderFlags: '.
	imageHeaderFlags storeOn: aStream.
	
	aStream nextPutAll: '; extraVMMemory: '.
	extraVMMemory storeOn: aStream.
	
