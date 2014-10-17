execution
testResetCPU
	"self new testResetCPU"
	self integerRegisterSetters do:
		[:setter|
		self processor perform: setter with: 16r55555555].
	self integerRegisterGetters do:
		[:getter|
		self assert: 16r55555555 = (self processor perform: getter)].
	self processor reset.
	self integerRegisterGetters do:
		[:getter|
		self assert: 0 = (self processor perform: getter)]