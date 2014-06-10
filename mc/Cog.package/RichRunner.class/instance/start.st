initialize
start
    | workQ |
    self initScheduler.
    self
	createIdler: Idler
	priority: 0
	work: nil
	state: RichTaskState running.
    workQ := self
		createPacket: nil
		identity: Worker
		kind: WorkPacketKind.
    workQ := self
		createPacket: workQ
		identity: Worker
		kind: WorkPacketKind.
    self
	createWorker: Worker
	priority: 1000
	work: workQ
	state: RichTaskState waitingWithPacket.
    workQ := self
		createPacket: nil
		identity: DeviceA
		kind: DevicePacketKind.
    workQ := self
		createPacket: workQ
		identity: DeviceA
		kind: DevicePacketKind.
    workQ := self
		createPacket: workQ
		identity: DeviceA
		kind: DevicePacketKind.
    self
	createHandler: HandlerA
	priority: 2000
	work: workQ
	state: RichTaskState waitingWithPacket.
    workQ := self
		createPacket: nil
		identity: DeviceB
		kind: DevicePacketKind.
    workQ := self
		createPacket: workQ
		identity: DeviceB
		kind: DevicePacketKind.
    workQ := self
		createPacket: workQ
		identity: DeviceB
		kind: DevicePacketKind.
    self
	createHandler: HandlerB
	priority: 3000
	work: workQ
	state: RichTaskState waitingWithPacket.
    self
	createDevice: DeviceA
	priority: 4000
	work: nil
	state: RichTaskState waiting.
    self
	createDevice: DeviceB
	priority: 5000
	work: nil
	state: RichTaskState waiting.
    self schedule.
    queuePacketCount = 23246 & (holdCount = 9297) ifFalse: [self error: 'wrong result'].
