page access
isFree: thePage
	"This is an anachronism.  Previously Slang couldn't generate the method correctly
	 from e.g. CogStackPageSurrogate>>isFree since Slang didn't do substitution on self.
	 Now it does, but there are still callers of isFree: so we keep this for simulation."
	<doNotGenerate>
	^thePage baseFP = 0