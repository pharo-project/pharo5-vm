primitives-rendering
primitiveRenderScanline
	"Start rendering the entire image"
	<export: true>
	<inline: false>
	| failCode |
	(failCode := self loadRenderingState) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failCode].

	self proceedRenderingScanline. "Finish the current scan line"

	self storeRenderingState.