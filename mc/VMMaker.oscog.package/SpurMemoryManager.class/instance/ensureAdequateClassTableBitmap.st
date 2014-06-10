class table
ensureAdequateClassTableBitmap
	"The classTableBitmap is used to reclaim unused and/or duplicate entries
	 in the classTable.  As such it is notionally 2^(22 - 3) bytes big, or 512k,
	 a little too large to be comfortable allocating statically (especially on small
	 machines).  So make it big enough for the max classTableIndex's base 2 ceiling."
	<inline: false>
	| requiredSize |
	requiredSize := (1 << numClassTablePages highBit)
					* (self classTablePageSize / BitsPerByte).
	self cCode:
			[classTableBitmap ifNotNil:
				[self free: classTableBitmap].
			 classTableBitmap := self malloc: requiredSize.
			 classTableBitmap ifNil:
				[self error: 'could not allocate classTableBitmap'].
			 self me: classTableBitmap ms: 0 et: requiredSize]
		inSmalltalk:
			[classTableBitmap := CArrayAccessor on: (ByteArray new: requiredSize)]