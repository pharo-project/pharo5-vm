growing/shrinking memory
assimilateNewSegment: segInfo
	"Update after adding a segment.
	 Here we make sure the new segment is not executable."
	<var: #segInfo type: #'SpurSegmentInfo *'>
	super assimilateNewSegment: segInfo.
	self 
		cppIf: #SPUR_USE_EXECUTABLE_MEMORY
		ifTrue: [ coInterpreter sqMakeMemoryExecutableFrom: segInfo segStart To: segInfo segLimit ]
		ifFalse: [ coInterpreter sqMakeMemoryNotExecutableFrom: segInfo segStart To: segInfo segLimit ]
		