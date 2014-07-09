*SpurVMMakerPharoCompatibility
schematicTempNamesString
	"Answer the temp names for the current method node in a form that captures
	 temp structure.  The temps at each method and block scope level occur
	 space-separated, with any indirect temps enclosed in parentheses.  Each block
	 level is enclosed in square brackets.  e.g.
		'method level temps (indirect temp)[block args and temps (indirect)]'
	 This representation can be reconstituted into a blockExtentsToTempsMap
	 by a CompiledMethod that has been copied with the schematicTempNamesString."
	encoder hasGeneratedMethod ifFalse:
		["create the encoder's blockExtentsToLoals map, except if the method is quick
		  in which case it has no temps."
		(self generate) isQuick ifTrue:
			[^'']].
	^encoder schematicTempNamesString