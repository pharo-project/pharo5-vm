compile abstract instructions
getInlineCacheClassTagFrom: sourceReg into: destReg
	"Extract the inline cache tag for the object in sourceReg into destReg. The inline cache tag
	 for a given object is the value loaded in inline caches to distinguish objects of different
	 classes.  In Spur this is either the tags for immediates, or the receiver's classIndex."
	^self subclassResponsibility