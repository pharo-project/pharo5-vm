primitive support
determineSizeOfWriteStream: rcvr
	"Determine the inst size of the class above DeflateStream or
	 ZipEncoder by looking for the first class whose inst size is less than 7."
	| class |
	class := interpreterProxy fetchClassOf: rcvr.
	[class ~= interpreterProxy nilObject
	 and: [(interpreterProxy instanceSizeOf: class) >= 7]] whileTrue:
		[class := interpreterProxy superclassOf: class].
	class = interpreterProxy nilObject ifTrue:
		[^false].
	writeStreamInstSize := interpreterProxy instanceSizeOf: class.
	^true
