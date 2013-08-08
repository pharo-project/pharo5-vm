initialize-release
initialize
	bodies := (OrderedCollection new
		add: ShootoutBody sun; add: ShootoutBody jupiter; add: ShootoutBody saturn;
		add: ShootoutBody uranus; add: ShootoutBody neptune; yourself) asArray.

	bodies first offsetMomentum:
		(bodies inject: (Array with: 0.0 with: 0.0 with: 0.0)
			into: [:m :each | each addMomentumTo: m])