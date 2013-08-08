accessing
strcpyFrom: startIndex "<Integer> ^<ByteString>"
	| length string |
	length := self strlenStartingAt: startIndex.
	string := ByteString new: length.
	self copyInto: string
		from: 1
		to: length 
		in: self
		startingAt: startIndex .
	^string