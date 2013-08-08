instance creation
named: anInteger next: aThread done: aSemaphore output: aStream
   ^self new name: anInteger; nextThread: aThread; done: aSemaphore; output: aStream; fork 