util
digitSizeOfLargeInt: anOop
	"answer number of 32 bits digits of a Large Integer"
	<inline: true>
	^(self byteSizeOfLargeInt: anOop) + 3 // 4