util
byteSizeOfCSI: csi 
	"Answer the number of bytes required to represent the value of a C-SmallInteger."
	csi >= 0 ifTrue:
		[csi < 256 ifTrue:
			[^1].
		 csi < 65536 ifTrue:
			[^2].
		 csi < 16777216 ifTrue:
			[^3].
		 self cppIf: interpreterProxy bytesPerOop = 4
			ifTrue:
				[^4]
			ifFalse:
				[csi < 4294967296 ifTrue:
					[^4].
				 csi < 1099511627776 ifTrue:
					[^5].
				 csi < 281474976710656 ifTrue:
					[^6].
				 csi < 72057594037927936 ifTrue:
					[^7].
				 ^8]].
	csi > -256 ifTrue:
		[^1].
	csi > -65536 ifTrue:
		[^2].
	csi > -16777216 ifTrue:
		[^3].
	self cppIf: interpreterProxy bytesPerOop = 4
		ifTrue:
			[^4]
		ifFalse:
			[csi > -4294967296 ifTrue:
				[^4].
			 csi > -1099511627776 ifTrue:
				[^5].
			 csi > -281474976710656 ifTrue:
				[^6].
			 csi > -72057594037927936 ifTrue:
				[^7].
			^8]