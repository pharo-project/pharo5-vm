accessing
stackPageInterruptHeadroomBytes
	"Return a minimum amount of headroom for each stack page (in bytes).  In a
	 JIT the stack has to have room for interrupt handlers which will run on the stack."
	self subclassResponsibility