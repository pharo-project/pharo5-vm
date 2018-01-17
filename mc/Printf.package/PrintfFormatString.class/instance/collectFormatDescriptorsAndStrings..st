private
collectFormatDescriptorsAndStrings: formatStream
	format := ReadWriteStream on: (Array new: 10).
	string := ReadWriteStream on: (Array new: 10).
	["copy actual formatstrings to format"
	 string nextPut: (self scanStringFrom: formatStream).
	 formatStream atEnd ifTrue:
		[self reset.
		 ^self].
	 "copy any nonformating text to string"
	 format nextPut: (PrintfFormatDescriptor scanFrom: formatStream)] repeat