system control primitives
primitiveFlushCacheByMethod
	"The receiver is a compiledMethod.  Clear all entries in the method lookup cache that
	 refer to this method, presumably because it has been redefined, overridden or removed.
	 Override to flush appropriate machine code caches also."
	super primitiveFlushCacheByMethod.
	cogit unlinkSendsTo: self stackTop andFreeIf: false