primitive support
determineSizeOfReadStream: rcvr
	"Determine the inst size of the class above DeflateStream by
	 looking for the first class whose inst size is less than 13."
	| class |
	class := interpreterProxy fetchClassOf: rcvr.
	[class ~= interpreterProxy nilObject
	 and: [(interpreterProxy instanceSizeOf: class) >= 13]] whileTrue:
		[class := interpreterProxy superclassOf: class].
	class = interpreterProxy nilObject ifTrue:
		[^false].
	readStreamInstSize := interpreterProxy instanceSizeOf: class.
	^true