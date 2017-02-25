image segment in/out
primitiveLoadImageSegment
	"This primitive is called from Squeak as...
		<imageSegment> loadSegmentFrom: aWordArray outPointers: anArray."

	"This primitive will load a binary image segment created by primitiveStoreImageSegment.
	 It expects the outPointer array to be of the proper size, and the wordArray to be well
	 formed.  It will return as its value the original array of roots, and the erstwhile
	 segmentWordArray will have been truncated to a size of one word, i.e. retaining the version
	 stamp.  If this primitive should fail, the segmentWordArray will, sadly, have been reduced to
	 an unrecognizable and unusable jumble.  But what more could you have done with it anyway?"

	| outPointerArray segmentWordArray result |

	outPointerArray := self stackTop.
	segmentWordArray := self stackValue: 1.

	"Essential type checks"
	((objectMemory isArray: outPointerArray)		"Must be indexable pointers"
	 and: [objectMemory isWords: segmentWordArray])	"Must be indexable words"
		ifFalse: [^self primitiveFail].

	"the engine returns the roots array which was first in the segment, or an error code on failure."
	result := objectMemory loadImageSegmentFrom: segmentWordArray outPointers: outPointerArray.
	(self oop: result isGreaterThan: segmentWordArray)
		ifTrue: [self pop: 3 thenPush: result]
		ifFalse: [self primitiveFailFor: result]