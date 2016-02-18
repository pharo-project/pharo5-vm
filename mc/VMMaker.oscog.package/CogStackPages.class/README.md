I am a class that helps organize the StackInterpreter's collection of stack pages.  I hold the set of stack pages represented by InterpreterStackPage instances/StackPage structs.  The pages are held in a doubly-linked list that notionally has two heads:

mostRecentlyUsedPage-->used page<->used page<->used page<->used page<--leastRecentlyUsedPage
                                       ^                        <-next-prev->                         ^
                                        |                                                                       |
                                        v                        <-prev-next->                         v
                                        free page<->free page<->free page<->free page

In fact we don't need the least-recently-used page, and so it is only present conceptually.  The point is that there is a possibly empty but contiguous sequence of free pages starting at mostRecentlyUsedPage nextPage.  New pages are allocated preferentially from the free page next to the MRUP.
If there are no free pages then (effectively) the LRUP's frames are flushed to contexts and it is used instead.

I have two concrete classes, one for the StackInterpreter and one for the CoInterpreter.

Instance Variables
	bytesPerPage:						<Integer>
	coInterpreter:						<StackInterpreter>
	mostRecentlyUsedPage:			<CogStackPage>
	objectMemory:						<ObjectMemory|SpurMemoryManager>
	overflowLimit:						<Integer>
	pages:								<Array of: CogStackPage>
	statNumMaps:						<Integer>
	statPageCountWhenMappingSum:		<Integer>

bytesPerPage
	- the size of a page in bytes

coInterpreter
	- the interpreter the receiver is holding pages for

mostRecentlyUsedPage
	- the most recently used stack page

objectMemory
	- the objectMemory of the interpreter

overflowLimit
	- the length in bytes of the portion of teh stack that can be used for frames before the page is judged to have overflowed

pages
	- the collection of stack pages the receiver is managing

statNumMaps
	- the number of mapStackPages calls

statPageCountWhenMappingSum:
	- the sum of the number of in use pages at each mapStackPages, used to estimate the average number of in use pages at scavenge, which heavily influences scavenger performance
