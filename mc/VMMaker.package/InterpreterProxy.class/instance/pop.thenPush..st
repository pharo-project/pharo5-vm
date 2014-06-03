stack access
pop: nItems thenPush: oop
	self pop: nItems.
	self push: oop.