printing
storeOn: aStream
	"We don't care about storing these things properly.  Doing so involves printing an entire VM.
	 So simply print and hence get debuggable CompiledMethods whose literals are VMObjectProxys."
	^self printOn: aStream