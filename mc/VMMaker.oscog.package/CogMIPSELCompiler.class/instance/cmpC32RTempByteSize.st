accessing
cmpC32RTempByteSize
	self flag: #todo. "value - reg or reg - value?"
	self flag: #inefficient. "Cog RTL assumes we can do any kind of conditional branch after a Cmp."
	^28