class table
inClassTableBitmapSet: classIndex
	| bit majorIndex |
	self assert: (classIndex >= self firstClassIndexPun
				 and: [classIndex <= self classIndexMask]).
	majorIndex := classIndex // BitsPerByte.
	bit := 1 << (classIndex bitAnd: BitsPerByte - 1).
	classTableBitmap
		at: majorIndex
		put: ((classTableBitmap at: majorIndex) bitOr: bit)