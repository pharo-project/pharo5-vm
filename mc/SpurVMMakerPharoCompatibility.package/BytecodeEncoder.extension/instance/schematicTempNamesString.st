*SpurVMMakerPharoCompatibility
schematicTempNamesString
	"Answer the temp names for the current method node in a form that captures
	 temp structure.  The temps at each method and block scope level occurr
	 space-separated, with any indirect temps enclosed in parentheses.  Each block
	 level is enclosed in square brackets.  e.g.
		'method level temps (indirect temp)[block args and temps (indirect)]'
	 This representation can be reconstituted into a blockExtentsToTempsMap
	 by a CompiledMethod that has been copied with teh schematicTempNamesString."
	blockExtentsToLocals ifNil:
		[self error: 'blockExtentsToLocals uninitialized.  method not yet generated?'].
	^String streamContents:
		[:aStream|
		self printSchematicTempNamesOn: aStream
			blockExtents: (blockExtentsToLocals keys asArray sort:
							[:range1 :range2|
							range1 first <= range2 first])
			fromIndex: 1]