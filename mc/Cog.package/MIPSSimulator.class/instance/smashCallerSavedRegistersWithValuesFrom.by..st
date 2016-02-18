processor api
smashCallerSavedRegistersWithValuesFrom: base by: step
	"i.e., smashVolatileRegisters"
	self flag: #OABI.
	self unsignedRegister: AT put: 0 * step + base.
	self unsignedRegister: V0 put: 0 * step + base.
	self unsignedRegister: V1 put: 0 * step + base.
	self unsignedRegister: A0 put: 0 * step + base.
	self unsignedRegister: A1 put: 0 * step + base.
	self unsignedRegister: A2 put: 0 * step + base.
	self unsignedRegister: A3 put: 0 * step + base.
	self unsignedRegister: T0 put: 0 * step + base.
	self unsignedRegister: T1 put: 0 * step + base.
	self unsignedRegister: T2 put: 0 * step + base.
	self unsignedRegister: T3 put: 0 * step + base.
	self unsignedRegister: T4 put: 0 * step + base.
	self unsignedRegister: T5 put: 0 * step + base.
	self unsignedRegister: T6 put: 0 * step + base.
	self unsignedRegister: T7 put: 0 * step + base.
	self unsignedRegister: T8 put: 0 * step + base.
	self unsignedRegister: T9 put: 0 * step + base.
	self unsignedRegister: GP put: 0 * step + base.
	self unsignedRegister: RA put: 0 * step + base.