processor api
smashRegistersWithValuesFrom: base by: step
	2 to: 31 do: [:index | self unsignedRegister: index put: index - 1 * step + base].
