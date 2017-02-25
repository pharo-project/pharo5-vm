class table puns
isForwardedObjectClassIndexPun
	"Answer the class index of a forwarder.  We choose 8 so as not to
	 be confused with any immediate class (whose classIndex matches
	 its instances tag pattern), and because it is a power of two, which
	 allows us to generate a slightly slimmer test for isForwarded:."
	<api>
	<cmacro>
	^8