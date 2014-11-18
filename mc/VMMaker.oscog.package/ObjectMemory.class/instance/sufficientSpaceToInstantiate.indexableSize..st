allocation
sufficientSpaceToInstantiate: classOop indexableSize: size 
	"Return the number of bytes required to allocate an instance of the given class with the given number of indexable fields."
	"Details: For speed, over-estimate space needed for fixed fields or literals; the low space threshold is a blurry line."
	<var: #size type: #usqInt>
	| format allocSize |
	<inline: true>
	(format := self instSpecOfClass: classOop) < self firstByteFormat
		ifTrue:
			["indexable fields are words or pointers"
			size ~= 0 ifTrue:
				["fail if attempting to call new: on non-indexable class"
				 format < self arrayFormat ifTrue:
					[^false].
				 "fail if attempting to allocate over 2 Gb, since this overflows 32-bit arithmetic"
				 size >> (LongSizeNumBits - self shiftForWord) > 0 ifTrue:
					[^false]].
			allocSize := size * self wordSize]
		ifFalse:
			["indexable fields are bytes"
			 "fail if attempting to allocate over 2 Gb, since this overflows 32-bit arithmetic"
			 size >> LongSizeNumBits > 0 ifTrue:
				[^false].
			allocSize := size].
	^self sufficientSpaceToAllocate: 2500 + allocSize