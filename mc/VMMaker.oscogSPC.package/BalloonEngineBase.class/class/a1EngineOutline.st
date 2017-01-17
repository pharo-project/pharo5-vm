documentation
a1EngineOutline
	"The following is a brief outline on how the engine works.

	In general, we're using a pretty straight-forward active edge approach, e.g., 
	we classify all edges into three different states:
		a) Waiting for processing
		b) Active (e.g., being processed)
		c) Finished
	Before the engine starts all edges are sorted by their y-value in a so-called
	'global edge table' (furthermore referred to as GET) and processed in top 
	to bottom order (the edges are also sorted by x-value but this is only for 
	simplifying the insertion when adding edges).

	Then, we start at the first visible scan line and execute the following steps:

	1) Move all edges starting at the current scan line from state a) to state b)

	This step requires the GET to be sorted so that we only need to check
	the first edges of the GET. After the initial state of the edge (e.g., it's current
	pixel value and data required for incremental updates) the edges are then 
	inserted in the 'active edge table' (called AET). The sort order in the AET is 
	defined by the pixel position of each edge at the current scan line and thus 
	edges are kept in increasing x-order.

	This step does occur for every edge only once and is therefore not the most
	time-critical part of the approach.

	2) Draw the current scan line

	This step includes two sub-parts. In the first part, the scan line is assembled.
	This involves walking through the AET and drawing the pixels between
	each two neighbour edges. Since each edge can have two associated fills
	(a 'left' and a 'right' fill) we need to make sure that edges falling on the
	same pixel position do not affect the painted image. This issue is discussed
	in the aetScanningProblems documentation.

	Wide edges (e.g., edges having an associated width) are also handled during
	this step. Wide edges are always preferred over interior fills - this ensures
	that the outline of an object cannot be overdrawn by any interior fill of
	a shape that ends very close to the edge (for more information see wideEdges 
	documentation).

	After the scan is assembled it is blitted to the screen. This only happens all
	'aaLevel' scan lines (for further information see the antiAliasing documentation).

	This second step is done at each scan line in the image, and is usually the most
	time-critical part.

	3) Update all currently active edges

	Updating the active edges basically means either to remove the edge from the AET
	(if it is at the end y value) or incrementally computing the pixel value for the
	next scan line. Based on the information gathered in the first step, this part
	should be executed as fast as possible - it happens for each edge in the AET
	at each scan line and may be the bottleneck if many edges are involved in
	the drawing operations (see the TODO list; part of it probably deals with the
	issue).

"
	^self error:'Comment only'