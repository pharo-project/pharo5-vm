system primitives
primitiveHostWindowScreenWorkAreaPosition: windex
	<option: #TerfVM>
	"Answer the platform's notion of the available work area on the screen containing the given window."
	| size |
	self primitive: 'primitiveHostWindowScreenWorkAreaPosition'
		parameters: #(SmallInteger).
	size := self ioPositionOfScreenWorkArea: windex.
	size = -1 ifTrue:
		[^interpreterProxy primitiveFail].
	^self pointFromCompactPointEncoding: size