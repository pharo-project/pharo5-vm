method map
mapFor: cogMethod do: aBlock
	<doNotGenerate>
	self mapFor: cogMethod performUntil: #withAnnotation:pc:evaluate: arg: aBlock