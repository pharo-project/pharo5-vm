stack pages
stackPageFrameBytes
	"Answer a byte size that accomodates a useful number of frames.
	 512 bytes is room for around 40 frames a page which is a good
	 compromise between overflow rate and latency in divorcing a page."
	^512