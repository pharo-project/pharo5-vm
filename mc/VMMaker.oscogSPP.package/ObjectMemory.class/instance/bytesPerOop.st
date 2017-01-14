accessing
bytesPerOop
	"N.B. This would appear to hard-code the header size for 32-bit images.  But if generating
	 a 64-bit image, this method could be removed and the relevant one substituted.  We can't
	 mark this method as <doNotGenerate> as we need an actual method to guide code gen."
	^4