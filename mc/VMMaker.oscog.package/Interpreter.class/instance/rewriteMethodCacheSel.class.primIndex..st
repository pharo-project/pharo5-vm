method lookup cache
rewriteMethodCacheSel: selector class: class primIndex: localPrimIndex

	"Rewrite the cache entry with the given primitive index and matching function pointer"
	| primPtr |
	<var: #primPtr type: 'void *'>
	<inline: false>
	localPrimIndex = 0
		ifTrue: [primPtr := 0]
		ifFalse: [primPtr := primitiveTable at: localPrimIndex].
	self
		rewriteMethodCacheSel: selector class: class
		primIndex: localPrimIndex primFunction: primPtr