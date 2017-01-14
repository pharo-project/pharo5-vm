primitive support
fetchLightSource: index ofObject: anArray
	"Fetch the primitive light source from the given array.
	Note: No checks are done within here - that happened in stackLightArrayValue:"
	| lightOop |
	<inline: true>
	<returnTypeC:'void*'>
	lightOop := interpreterProxy fetchPointer: index ofObject: anArray.
	^interpreterProxy firstIndexableField: lightOop