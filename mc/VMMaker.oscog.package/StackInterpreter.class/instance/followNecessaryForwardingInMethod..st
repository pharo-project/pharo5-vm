lazy become
followNecessaryForwardingInMethod: methodObj
	"To avoid any chance of a forwarded object during super sends we follow the
	 methodClassAssociation.  The forwarded object send fault only copes with
	 normal sends to instances."
	<inline: false>
	objectMemory hasSpurMemoryManagerAPI ifTrue:
		[self actuallyFollowNecessaryForwardingInMethod: methodObj]