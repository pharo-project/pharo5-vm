tests
testResetCPU
	"self new testResetCPU"
	self registerSetters do:
		[:setter|
		self processor perform: setter with: 16r55555555].
	self registerGetters do:
		[:getter|
		self assert: 16r55555555 = (self processor perform: getter)].
	self processor reset.
	self registerGetters do:
		[:getter|
		self assert: 0 = (self processor perform: getter)]