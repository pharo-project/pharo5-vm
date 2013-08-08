marshalling
cStackAlignment
	"Many ABIs mandate a particular stack alignment greater than the natural word size.
	 If so, this macro will answer that alignment.  If not, this macro will answer 0.  See
	 class-side preambleCCode."
	<cmacro: '() STACK_ALIGN_BYTES'>
	^0