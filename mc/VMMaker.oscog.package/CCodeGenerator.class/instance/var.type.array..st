public
var: varName type: cType array: array
	"Use this in preference to #var:declareC: when possible. This produces a C
	 statment of the form
		int * fooArray[]={1,2,3}
	 See also #var:type: for simple var decls" 
	self
		var: varName
		declareC: (self arrayInitializerCalled: varName for: array sizeString: nil type: cType)