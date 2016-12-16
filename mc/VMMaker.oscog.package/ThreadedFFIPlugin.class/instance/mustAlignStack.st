marshalling
mustAlignStack
	"Many ABIs mandate a particular stack alignment greater than the natural word size.
	 If so, this macro will answer true.  See class-side preambleCCode."
	<cmacro: '() MUST_ALIGN_STACK'>
	^false