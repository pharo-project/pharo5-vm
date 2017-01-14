initialization
initialCleanup
	"Images written by VMs earlier than 3.6/3.7 will wrongly have the root bit set on the active context. Besides clearing the root bit, we treat this as a marker that these images also lack a cleanup of external primitives (which has been introduced at the same time when the root bit problem was fixed). In this case, we merely flush them from here."

	((self longAt: activeContext) bitAnd: RootBit) = 0 ifTrue:[^nil]. "root bit is clean"
	"Clean root bit of activeContext"
	self longAt: activeContext put: ((self longAt: activeContext) bitAnd: AllButRootBit).
	"Clean external primitives"
	self flushExternalPrimitives.