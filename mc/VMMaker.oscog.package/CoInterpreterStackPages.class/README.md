I am a class that helps organize the CoInterpreter's collection of stack pages.  I hold the set of stack pages represented by CogStackPageSurrogate instances/StackPage structs.  The pages are held in a doubly-linked list that notionally has two heads:

mostRecentlyUsedPage-->used page<->used page<->used page<->used page<--leastRecentlyUsedPage
                                       ^                        <-next-prev->                         ^
                                        |                                                                       |
                                        v                        <-prev-next->                         v
                                        free page<->free page<->free page<->free page

In fact we don't need the least-recently-used page, and so it is only present conceptually.  The point is that there is a possibly empty but contiguous sequence of free pages starting at mostRecentlyUsedPage nextPage.  New pages are allocated preferentially from the free page next to the MRUP.
If there are no free pages then (effectively) the LRUP's frames are flushed to contexts and it is used instead.

Instance Variables
	maxStackAddress:		<Integer>
	minStackAddress:		<Integer>
	pageMap:				<Dictionary>
	stackBasePlus1:		<Integer>

maxStackAddress
	- the maximum valid byte address in the stack zone

minStackAddress
	- the minimum valid byte address in the stack zone

pageMap
	- a map from address to the CogStackPageSurrogate for that address

stackBasePlus1
	- the address of the 2nd byte in the stack memory, used for mapping stack addresses to page indices