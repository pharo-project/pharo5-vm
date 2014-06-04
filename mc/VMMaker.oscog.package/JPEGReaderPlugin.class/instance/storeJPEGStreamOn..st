stream support
storeJPEGStreamOn: streamOop
	interpreterProxy storeInteger: 1 ofObject: streamOop withValue: jsPosition.
	interpreterProxy storeInteger: 3 ofObject: streamOop withValue: jsBitBuffer.
	interpreterProxy storeInteger: 4 ofObject: streamOop withValue: jsBitCount.