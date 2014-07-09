*SpurVMMakerPharoCompatibility
tempNames: aString
	"Embed the temp names string into compiled method trailer, 
	pick best compression method"
	| temp |
	self clear.
	kind := #TempsNamesQCompress.
	data := aString.
	
	self encode.
	temp := encodedData.

	kind := #TempsNamesZip.
	self encode.
	encodedData size > temp size ifTrue: [
		encodedData := temp.
		kind := #TempsNamesQCompress.
		size := encodedData size.
		]