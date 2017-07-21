system primitives
primitiveHostWindowScreenWorkAreaSize: windex
	<option: #TerfVM>
	"Answer the platform's notion of the available work area on the screen containing the given window."
	| size |
	self primitive: 'primitiveHostWindowScreenWorkAreaSize'
		parameters: #(SmallInteger).
	size := self ioSizeOfScreenWorkArea: windex.
	size = -1 ifTrue:
		[^interpreterProxy primitiveFail].
	^self pointFromCompactPointEncoding: size