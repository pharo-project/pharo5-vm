stack pages
stackPageHeadroom
	"Return a minimum amount of headroom for each stack page (in bytes).
	 In the interpreter we don't actually need any headroom.  In a JIT the stack
	 has to have room for interrupt handlers which will run on the stack.
	 Defer to the platform for this one."
	<inline: true>
	^self osCogStackPageHeadroom