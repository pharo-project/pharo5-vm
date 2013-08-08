version testing
canAccessSystem
	"True if an installed OSPP is available and can access the system"

	"OSProcessPlugin concreteClass canAccessSystem"

	^ self concreteClass primGetPid notNil
