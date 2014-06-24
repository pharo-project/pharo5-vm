instance creation
fromStream: stream
	"Answer a new instance from a saved image file stream. Word size and byte ordering
	are dependent on the image and platform that saved the file, and must be decoded
	to obtain the image format. There may be a 512 byte offset, also."

	{ 0 . 512 } do: [:offset | | num |
		[stream position: offset.
		num := stream nextNumber: 4.  "try 32 bit big endian format"
		^ self fromInteger: num]
			on: Error
			do: [[stream position: offset.
				num := stream nextLittleEndianNumber: 4. "try 32 bit little endian format"
				^ self fromInteger: num]
				on: Error
				do: [[stream position: offset.
					num := stream nextNumber: 8. "try 64 bit big endian format"
					^ self fromInteger: num]
					on: Error
					do: [[stream position: offset.
						num := stream nextLittleEndianNumber: 8. "try 64 bit little endian format"
						^ self fromInteger: num]
						on: Error
						do: ["nothing. fall through for possible second round."]]]]].
	self error: 'unrecognized image format'