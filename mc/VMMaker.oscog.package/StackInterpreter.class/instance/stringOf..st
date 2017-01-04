debug support
stringOf: oop
	<doNotGenerate>
	| size long nLongs chars |
	^ String streamContents:
		[:strm |
		size := 128 min: (self stSizeOf: oop).
		nLongs := size-1//objectMemory wordSize+1.
		1 to: nLongs do:
			[:i | long := objectMemory longAt: oop + objectMemory baseHeaderSize + (i-1*objectMemory wordSize).
			chars := self charsOfLong: long.
			strm nextPutAll: (i=nLongs
							ifTrue: [chars copyFrom: 1 to: size-1\\objectMemory wordSize+1]
							ifFalse: [chars])]]