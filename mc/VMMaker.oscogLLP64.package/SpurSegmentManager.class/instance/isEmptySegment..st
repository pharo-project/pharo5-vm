growing/shrinking memory
isEmptySegment: seg
	<var: #seg type: #'SpurSegmentInfo *'>
	| firstObj |
	firstObj := manager objectStartingAt: seg segStart.
	^(manager isFreeObject: firstObj)
	  and: [(manager addressAfter: firstObj) = (seg segLimit - manager bridgeSize)]