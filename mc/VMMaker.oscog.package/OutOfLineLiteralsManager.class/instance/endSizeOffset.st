closed PIC parsing
endSizeOffset
	"return the offset need from the cPICEndSize in order to point to just after the last instruction - here that means bytesPerOop * list size"
	^nextLiteralIndex * objectMemory bytesPerOop