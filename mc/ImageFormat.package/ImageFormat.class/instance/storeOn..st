printing
storeOn: aStream 
	"Append to the argument aStream a sequence of characters that is an 
	expression whose evaluation creates an object similar to the receiver."

	aStream nextPutAll: self class name;
		nextPutAll: ' fromInteger: ';
		nextPutAll: self asInteger asString