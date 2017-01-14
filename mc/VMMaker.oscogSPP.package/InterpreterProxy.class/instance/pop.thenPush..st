stack access
pop: nItems thenPush: oop
	<returnTypeC: #sqInt>
	self pop: nItems.
	self push: oop