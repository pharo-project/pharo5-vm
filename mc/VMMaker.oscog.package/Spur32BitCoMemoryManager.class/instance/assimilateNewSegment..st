growing/shrinking memory
assimilateNewSegment: segInfo
	"Update after adding a segment.
	 Here we make sure the new segment is not executable."
	<var: #segInfo type: #'SpurSegmentInfo *'>
	super assimilateNewSegment: segInfo.
	coInterpreter sqMakeMemoryNotExecutableFrom: segInfo segStart To: segInfo segLimit