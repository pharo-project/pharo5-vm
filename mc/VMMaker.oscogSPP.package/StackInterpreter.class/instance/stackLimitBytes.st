stack pages
stackLimitBytes
	"Answer the actual stackLimit offset in a page.  Since stackPageByteSize may have chosen to shrink a page
	 this may be less than stackPageFrameBytes, but it should be no more than stackPageFrameBytes."
	^self stackPageFrameBytes min: self stackPageByteSize - self stackLimitOffset - self stackPageHeadroom.