snapshot
adjustSegmentSwizzlesBy: firstSegmentShift
	"Adjust swizzles by firstSegmentShift.  Also computes segStarts as
	 they were in the image when it was written, so that oops' segments
	 can be determined and hence oops correctly swizzled."
	<inline: false>
	<var: 'segInfo' type: #'SpurSegmentInfo *'>
	| oldBaseAddr |
	oldBaseAddr := manager memoryBaseForImageRead - firstSegmentShift.
	0 to: numSegments - 1 do:
		[:i| | segInfo |
		 segInfo := self addressOf: (segments at: i).
		 segInfo
			segStart: segInfo segStart + oldBaseAddr;
			swizzle: segInfo swizzle - oldBaseAddr].
	canSwizzle := true