header formats
isAnyPointerFormat: format
	"the inverse of isPureBitsFormat:"
	<inline: true>
	^format <= self lastPointerFormat or: [format >= self firstCompiledMethodFormat]