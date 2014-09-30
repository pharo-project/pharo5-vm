image segment in/out
primitiveStoreImageSegment
	"This primitive is called from Squeak as...
		<imageSegment> storeSegmentFor: arrayOfRoots into: aWordArray outPointers: anArray."

"This primitive will store a binary image segment (in the same format as the Squeak image file) of the receiver and every object in its proper tree of subParts (ie, that is not refered to from anywhere else outside the tree).  All pointers from within the tree to objects outside the tree will be copied into the array of outPointers.  In their place in the image segment will be an oop equal to the offset in the outPointer array (the first would be 4). but with the high bit set."

"The primitive expects the array and wordArray to be more than adequately long.  In this case it returns normally, and truncates the two arrays to exactly the right size.  To simplify truncation, both incoming arrays are required to be whatever the objectMemory considers  long objects.  If either array is too small, the primitive will fail, but in no other case."

	| outPointerArray segmentWordArray arrayOfRoots ecode |

	outPointerArray := self stackTop.
	segmentWordArray := self stackValue: 1.
	arrayOfRoots := self stackValue: 2.

	"Essential type checks"
	((self isArray: arrayOfRoots)						"Must be indexable pointers"
	and: [(self isArray: outPointerArray)					"Must be indexable pointers"
	and: [self isWords: segmentWordArray]]) ifFalse:	"Must be indexable words"
		[^self primitiveFail].

	ecode := self storeImageSegmentInto: segmentWordArray outPointers: outPointerArray roots: arrayOfRoots.
	ecode = PrimNoErr
		ifTrue: [self pop: 3]  "...leaving the receiver on the stack as return value"
		ifFalse: [self primitiveFail]