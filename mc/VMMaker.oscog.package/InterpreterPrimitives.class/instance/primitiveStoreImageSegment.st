image segment in/out
primitiveStoreImageSegment
	"This primitive is called from Squeak as...
		<imageSegment> storeSegmentFor: arrayOfRoots into: aWordArray outPointers: anArray."

"This primitive will store a binary image segment (in the same format as the Squeak image file) of the receiver and every object in its proper tree of subParts (ie, that is not refered to from anywhere else outside the tree).  All pointers from within the tree to objects outside the tree will be copied into the array of outpointers.  In their place in the image segment will be an oop equal to the offset in the outPointer array (the first would be 4). but with the high bit set."

"The primitive expects the array and wordArray to be more than adequately long.  In this case it returns normally, and truncates the two arrays to exactly the right size.  To simplify truncation, both incoming arrays are required to be 256 bytes or more long (ie with 3-word headers).  If either array is too small, the primitive will fail, but in no other case.

During operation of the primitive, it is necessary to convert from both internal and external oops to their mapped values.  To make this fast, the headers of the original objects in question are replaced by the mapped values (and this is noted by adding the forbidden XX header type).  Tables are kept of both kinds of oops, as well as of the original headers for restoration.

To be specific, there are two similar two-part tables, the outpointer array, and one in the upper fifth of the segmentWordArray.  Each grows oops from the bottom up, and preserved headers from halfway up.

In case of either success or failure, the headers must be restored.  In the event of primitive failure, the table of outpointers must also be nilled out (since the garbage in the high half will not have been discarded."

	| outPointerArray segmentWordArray arrayOfRoots ecode |

	outPointerArray := self stackTop.
	segmentWordArray := self stackValue: 1.
	arrayOfRoots := self stackValue: 2.

	"Essential type checks"
	((objectMemory isArray: arrayOfRoots)				"Must be indexable pointers"
	and: [(objectMemory isArray: outPointerArray)		"Must be indexable pointers"
	and: [objectMemory isWords: segmentWordArray]])	"Must be indexable words"
		ifFalse: [^self primitiveFail].

	ecode := objectMemory storeImageSegmentInto: segmentWordArray outPointers: outPointerArray roots: arrayOfRoots.
	ecode = PrimNoErr
		ifTrue: [self pop: 3]  "...leaving the receiver on the stack as return value"
		ifFalse: [self primitiveFailFor: ecode]