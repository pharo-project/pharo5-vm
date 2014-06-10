primitives-rendering
primitiveRenderImage
	"Start/Proceed rendering the entire image"
	<export: true>
	<inline: false>
	| failCode |
	(failCode := self loadRenderingState) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failCode].

	self proceedRenderingScanline. "Finish this scan line"
	engineStopped ifTrue:[^self storeRenderingState].
	self proceedRenderingImage. "And go on as usual"

	self storeRenderingState.