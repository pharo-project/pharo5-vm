method lookup cache
rewriteMethodCacheSel: selector class: class primIndex: localPrimIndex primFunction: localPrimAddress
	"Rewrite an existing entry in the method cache with a new primitive 
	index & function address. Used by primExternalCall to make direct jumps to found external prims"
	| probe hash |
	<inline: false>
	<var: #localPrimAddress type: 'void *'>
	hash := selector bitXor: class.
	0 to: CacheProbeMax - 1 do: [:p | 
			probe := hash >> p bitAnd: MethodCacheMask.
			((methodCache at: probe + MethodCacheSelector) = selector
					and: [(methodCache at: probe + MethodCacheClass) = class])
				ifTrue: [methodCache at: probe + MethodCachePrim put: localPrimIndex.
					methodCache at: probe + MethodCachePrimFunction put: (self cCoerce: localPrimAddress to: #'sqIntptr_t').
					^ nil]]