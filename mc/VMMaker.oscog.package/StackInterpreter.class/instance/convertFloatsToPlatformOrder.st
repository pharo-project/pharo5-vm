image save/restore
convertFloatsToPlatformOrder
	"Byte-swap the words of all bytes objects in a range of the 
	 image, including Strings, ByteArrays, and CompiledMethods.
	 This returns these objects to their original byte ordering 
	 after blindly byte-swapping the entire image. For compiled 
	 methods, byte-swap only their bytecodes part.
	 Ensure floats are in platform-order."
	objectMemory vmEndianness = imageFloatsBigEndian ifTrue:
		[^nil].
	self assert: ClassFloatCompactIndex ~= 0.
	objectMemory allObjectsDo:
		[:obj| | temp |
		(objectMemory compactClassIndexOf: obj) = ClassFloatCompactIndex ifTrue:
			[temp := self longAt: obj + BaseHeaderSize.
			 self longAt: obj + BaseHeaderSize put: (self longAt: obj + BaseHeaderSize + 4).
			 self longAt: obj + BaseHeaderSize + 4 put: temp]]