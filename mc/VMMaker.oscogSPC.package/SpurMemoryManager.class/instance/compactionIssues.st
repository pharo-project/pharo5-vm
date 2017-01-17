compaction - analysis
compactionIssues
	<doNotGenerate>
	"Compaction isn't working well.  It rarely moves more than a few tens of kilobytes.  Why?
	 Load an image and before you run it, or just before a GC, run these anaylsis routines.
	 e.g.
		self abstractCompaction #(63230272 75456 63210648)
	 shows we can move 75456 bytes of objects, but that would use 63210648 of free space.
	 i.e. there are lots of big free chunks in play, not many small ones that fit the bill.

		self largeFreeChunkDistribution
			#(	#('16r31C788' #nil)
				#('16r1423AC0' 2061864)
				#('16r1B705E8' 1515200)
				#('16r1D31D20' 2011152)
				#('16r1F37818' 1491480)
				#('16r2225968' 1450512)
				#('16r24C92C8' 48575672)  (16r24C92C8 + 48575672) hex '16r531C780' a free chunk
				#('16r531C788' #endOfMemory))
	 shows there's plenty of large free chunks.  And the trailing 16-byte free chunk shows coallescing is not working properly.

		self biggies #(#('16r31C788' #nil) #('16r531C788' #endOfMemory))
	 shows there are no large objects to be moved.

	 So... looks like compaction should hold onto the lowest large chunk and preferentially move objects into that.
	 Let's call it a pig.  Compaction needs to whittle away at the pig.

	 e.g.
		self abstractPigCompaction #(2061864 0 2061864 18759 2018224 34757)
	 shows we can move 18759 objects that will occupy 2018224 bytes into that
	 low pig of 2061864 bytes."