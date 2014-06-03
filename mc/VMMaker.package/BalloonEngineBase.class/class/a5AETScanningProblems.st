documentation
a5AETScanningProblems
	"Due to having two fill entries (one left and one right) there can be problems while scanning the active edge table. In general, the AET should look like the following (ri - regions, ei - edges, fi - fills):

			|				\				|
	r1		|		r2		 \		r3		|		r4
			|				  \				|
			e1				 e2				e3		

	with:
		f(r1) = fLeft(e1) = 0				(empty fill, denoted -)
		f(r2) = fRight(e1) = fLeft(e2)		(denoted x)
		f(r3) = fRight(e2) = fLeft(e3)	(denoted o)
		f(r4) = fRight(e3) = 0

	However, due to integer arithmetic used during computations the AET may look like the following:
			X
			\|						|
			 | \						|
			 |   \					|
	r1		 | r2 \			r3		|		r4
			 |	   \					|
			e1		e2				e3		

	In this case, the starting point of e1 and e2 have the same x value at the first scan line but e2 has been sorted before e1 (Note: This can happen in *many* cases - the above is just a very simple example). Given the above outlined fill relations we have a problem. So, for instance, using the left/right fills as defined by the edges would lead to the effect that in the first scan line region r3 is actually filled with the right fill of e1 while it should actually be filled with the right fill of e2. This leads to noticable artifacts in the image and increasing resolution does not help.

	What we do here is defining an arbitrary sort order between fills (you can think of it as a depth value but the only thing that matters is that you can order the fills by this number and that the empty fill is always sorted at the end), and toggle the fills between an 'active' and an 'inactive' state at each edge. This is done as follows:
	For each edge ei in the AET do:
		* if fLeft(ei) isActive then removeActive(fLeft(ei)) else addActive(fLeft(ei))
		* if fRight(ei) isActive then removeActive(fRight(ei)) else addActive(fRight(ei))
		* draw the span from ei to ei+1 with currentActive
	where addActive adds the fill to the list of currently active fills, removeActive() removes the fill from the active list and currentActive returns the fill AS DEFINED BY THE SORT ORDER from the list of active fills. Note that this does not change anything in the first example above because the list will only contain one entry (besides the empty fill). In the second case however, it will lead to the following sequence:

	* toggle fLeft(e2) = f(r2) = 'x'
		- makes fLeft(e2) active
		- activeList = 'x'
	* toggle fRight(e2) = f(r3) = 'o'
		- makes fRight(e2) active
		- activeList = 'xo'
	* draw span from e2 to e1
		Depending on the sort order between 'x' and 'o' the region will be drawn with either one of the fills. It is significant to note here that the occurence of such a problem is generally only *very* few pixels large (in the above example zero pixels) and will therefore not be visually noticable. In any case, there is a unique decision for the fill to use here and that is what we need if the problem did not happen accidentally (e.g., someone has manually changed one fill of an edge but not the fill of the opposite edge).

	* toggle fLeft(e1) = f(r1) = '-'
		- makes fLeft(r1) visible
		- activeList = 'xo-'
		[Note: empty fills are a special case. 
		They can be ignored since they sort last
		and the activeList can return the empty
		fill if it is itself empty].
	* toggle fRight(e1) = f(r2) = 'x'
		- makes fRight(e1) invisible
		- activeList = 'o-'
	* draw span from e2 to e3
		Since the active list contains (besides the empty fill) only one fill value this will be used. Fortunately, this is the correct fill because it is the fill we had initially defined for the region r2.

An interesting side effect of the above is that there is no such notion as a 'left' or 'right' fill anymore. Another (not-so-nice) side effect is that the entire AET has to be scanned from the beginning even if only the last few edges actually affect the visible region.

PS. I need to find a way of clipping the edges for this. More on it later...
"
	^self error:'Comment only'