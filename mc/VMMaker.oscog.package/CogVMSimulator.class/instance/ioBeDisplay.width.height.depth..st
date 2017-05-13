I/O primitives
ioBeDisplay: bitsOrHandleCArray width: width height: height depth: depth
	"The real platform may want to note the location of the display and respond to the fact of
	 its installation.  Here merely create a scratch form the same size as Smalltalk displayObj"
	super ioBeDisplay: bitsOrHandleCArray asInteger width: width height: height depth: depth.
	displayForm := Form extent: width @ height depth: depth.
	displayView ifNotNil: [displayView image: displayForm]