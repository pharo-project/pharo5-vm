utility
allVersionNumberByteArrays
	"All known version numbers expressed as byte arrays of size 4 and 8 in little
	endian and big endian byte ordering."

	"ImageFormat allVersionNumberByteArrays"

	| byteArrays |
	byteArrays := OrderedCollection new.
	KnownVersionNumbers do: [:version |
		byteArrays add: ((WriteStream on: (ByteArray new: 4)) nextNumber: 4 put: version; yourself) contents.
		byteArrays add: ((WriteStream on: (ByteArray new: 8)) nextNumber: 8 put: version; yourself) contents.
		byteArrays add: ((WriteStream on: (ByteArray new: 4)) nextLittleEndianNumber: 4 put: version; yourself) contents.
		byteArrays add: ((WriteStream on: (ByteArray new: 8)) nextLittleEndianNumber: 8 put: version; yourself) contents].
	^byteArrays