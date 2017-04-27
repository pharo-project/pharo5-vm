mesh processing
primitiveOptimizeVertexIndicesForCacheLocality
	"Given a list of integer indices for rendering a triangle-mesh in indexed-triangles mode, reorganize the indices in-place to provide better vertex cache locality.
	We use Tom Forsyth's algorithm:
		http://home.comcast.net/~tom_forsyth/papers/fast_vert_cache_opt.html
	... and the MIT-licensed implementation by Michael Georgoulpoulos at:
		http://code.google.com/p/vcacne/"
	| indicesOop indices byteSize triCount result |
	<export: true>
	<inline: true>
	<var: #indices type: 'void *'>

	"Get the oop of the IntegerArray containing the indices."
	(interpreterProxy methodArgumentCount = 1) ifFalse: [^interpreterProxy primitiveFail].
	indicesOop := interpreterProxy stackObjectValue: 0.
	interpreterProxy failed ifTrue: [^nil].
	(interpreterProxy isWords: indicesOop) ifFalse: [^interpreterProxy primitiveFail].
	
	"Ensure that the number of indices is a multiple of 3."
	byteSize := interpreterProxy byteSizeOf: indicesOop.
	triCount := byteSize / 12.
	(triCount * 12) = byteSize ifFalse: [^interpreterProxy primitiveFail].
	
	"Get an int* to the indices, and optimize 'em."
	indices := interpreterProxy firstIndexableField: indicesOop.
	self touch: indices.
	interpreterProxy failed ifTrue: [^nil].
	result := self cCode: 'optimizeVertexIndices((int*)indices, triCount)'.
	result = 0 "success" ifFalse: [^interpreterProxy primitiveFail].
	^interpreterProxy pop: 1