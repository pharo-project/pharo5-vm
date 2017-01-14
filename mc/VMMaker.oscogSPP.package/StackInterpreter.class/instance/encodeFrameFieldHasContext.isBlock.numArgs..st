frame access
encodeFrameFieldHasContext: hasContext "<Boolean>" isBlock: isBlock "<Boolean>" numArgs: numArgs
	"For ``fast'' temporary access (ok, to mitigate slower temp access) we need
	 fast access to a method's numArgs.  Could have a variable set on save and return.
	 We'll investigate this.  For the moment we just use a byte in the frameFlags
	 field.  This is endian dependent.  Store numArgs in byte at FoxFrameFields + 1.
	 Store hasContext flag in top bit (allows for 64-bit tags) of byte at FoxFrameFields.
	 Make frameFields look like a SmallInteger for the benefit of gc (dubious)."
	"bitsPerWord := BytesPerWord * 8"
	<inline: true>
	^VMBIGENDIAN
		ifTrue: [1
				+ (numArgs << ((objectMemory wordSize * 8) - 8))
				+ (hasContext ifTrue: [1 << ((objectMemory wordSize * 8) - 16)] ifFalse: [0])
				+  (isBlock ifTrue: [1 << ((objectMemory wordSize * 8) - 24)] ifFalse: [0])]
		ifFalse: [1
				+ (numArgs << 8)
				+  (hasContext ifTrue: [1 << 16] ifFalse: [0])
				+  (isBlock ifTrue: [1 << 24] ifFalse: [0])]