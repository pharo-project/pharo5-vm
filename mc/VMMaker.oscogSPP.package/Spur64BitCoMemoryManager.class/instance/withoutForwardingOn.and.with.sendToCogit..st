cog jit support
withoutForwardingOn: obj1 and: obj2 with: aBool sendToCogit: selector
	"For the purposes of become: send selector to the cogit with obj1, obj2
	 and aBool and answer the result.  Undo forwarding for the selector."
	<api>
	<var: #selector declareC: 'sqInt (*selector)(sqInt,sqInt,sqInt)'>
	| targetA targetB |
	targetA := self followForwarded: obj1.
	targetB := self followForwarded: obj2.
	^cogit perform: selector with: targetA with: targetB with: aBool