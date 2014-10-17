private
reservedNames
	"Return a list of names that must not be used for variables"
	^#('self' 'super' 'thisContext' 'true' 'false' 'nil' 
		self super thisContext #true #false #nil).