converting
asWideString

	| theSize bs |
	(theSize := self dataSize) < 0 ifTrue: [^self error: 'Invalid size for data'].
	bs := self primAEDescToString: (String new: theSize). 
	"bs inspect."
	^ bs asString convertFromWithConverter: UTF16TextConverter new.
