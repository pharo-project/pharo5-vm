compiled methods
unfollow: litVar atIndex: literalIndex
	<option: #SpurMemoryManager>
	<inline: #never> "So rare it mustn't bulk up the common path"
	| followed |
	followed := objectMemory followForwarded: litVar.
	self literal: literalIndex ofMethod: method put: followed.
	^followed