stack pages
stackPageHeadroom
	"Return a minimum amount of headroom for each stack page (in bytes).
	 In a JIT the stack has to have room for interrupt handlers which will run on the
	 stack.  In the interpreter we don't actually need any headroom."
	^0