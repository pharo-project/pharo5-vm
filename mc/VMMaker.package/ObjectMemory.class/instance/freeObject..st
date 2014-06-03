become
freeObject: obj
	| objHeader |
	objHeader := self baseHeader: obj.
	self freeObject: obj header: objHeader