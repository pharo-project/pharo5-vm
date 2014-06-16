printing
storeOn: aStream 
	"Append to the argument aStream a sequence of characters that is an 
	expression whose evaluation creates an object similar to the receiver."

	super storeOn: aStream.

	aStream nextPutAll: '; desiredNumStackPages: '.
	desiredNumStackPages storeOn: aStream.

	aStream nextPutAll: '; unknownShortOrCodeSizeInKs: '.
	unknownShortOrCodeSizeInKs storeOn: aStream.

	aStream nextPutAll: '; desiredEdenBytes: '.
	desiredEdenBytes storeOn: aStream.

	aStream nextPutAll: '; maxExtSemTabSizeSet: '.
	maxExtSemTabSizeSet storeOn: aStream.
