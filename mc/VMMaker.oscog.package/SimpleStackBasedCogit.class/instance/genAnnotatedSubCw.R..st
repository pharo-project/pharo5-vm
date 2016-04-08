constant support
genAnnotatedSubCw: constant R: reg
	"generates a SubCW instruction with an explicit annotation. This is called (as of today) only by the branch generation methods.
	The annotation needs to be there for some reasons unknown to me (removing the annotation crashes the must be boolean trampolines)"
	<inline: true>
	self flag: #TOCHECK. "We will check with eliot if this could be a SubCq, and if not, put the proper comment"
	self annotate: (self SubCw: constant R: TempReg) objRef: reg.
	