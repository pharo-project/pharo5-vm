initialization
initialCleanup
	"This used to cope with issues with images written by VMs earlier than 3.6/3.7.
	 Since we won't be loading such images (being a closure only VM) we only have to
	 deal with external primitives.  Since references to external plugins in methods are
	 cleaned up in snapshotCleanUp only initialize the tables, not visit each method."
	<inline: true>
	self flushMethodCache.
	self flushExternalPrimitiveTable