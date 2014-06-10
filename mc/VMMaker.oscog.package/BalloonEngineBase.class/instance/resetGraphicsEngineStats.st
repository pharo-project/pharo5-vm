other
resetGraphicsEngineStats
	<inline: false>
	workBuffer at: GWTimeInitializing put: 0.
	workBuffer at: GWTimeFinishTest put: 0.
	workBuffer at: GWTimeNextGETEntry put: 0.
	workBuffer at: GWTimeAddAETEntry put: 0.
	workBuffer at: GWTimeNextFillEntry put: 0.
	workBuffer at: GWTimeMergeFill put: 0.
	workBuffer at: GWTimeDisplaySpan put: 0.
	workBuffer at: GWTimeNextAETEntry put: 0.
	workBuffer at: GWTimeChangeAETEntry put: 0.

	workBuffer at: GWCountInitializing put: 0.
	workBuffer at: GWCountFinishTest put: 0.
	workBuffer at: GWCountNextGETEntry put: 0.
	workBuffer at: GWCountAddAETEntry put: 0.
	workBuffer at: GWCountNextFillEntry put: 0.
	workBuffer at: GWCountMergeFill put: 0.
	workBuffer at: GWCountDisplaySpan put: 0.
	workBuffer at: GWCountNextAETEntry put: 0.
	workBuffer at: GWCountChangeAETEntry put: 0.

	workBuffer at: GWBezierMonotonSubdivisions put: 0.
	workBuffer at: GWBezierHeightSubdivisions put: 0.
	workBuffer at: GWBezierOverflowSubdivisions put: 0.
	workBuffer at: GWBezierLineConversions put: 0.
