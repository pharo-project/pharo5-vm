object memory support
followForwardedMethodsInMethodCache
	0 to: MethodCacheSize - 1 by: MethodCacheEntrySize do:
		[:i | | c s m |
		c := methodCache at: i + MethodCacheClass.
		s := methodCache at: i + MethodCacheSelector.
		m := methodCache at: i + MethodCacheMethod.
		(c ~= 0 and: [s ~= 0 and: [m ~= 0
		 and: [objectMemory isOopForwarded: m]]]) ifTrue:
			[m := objectMemory followForwarded: m.
			 methodCache at: i + MethodCacheMethod put: m]]