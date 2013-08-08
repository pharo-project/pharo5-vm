initialize-release
initialize
   "Initialize a newly created instance. This method must answer the receiver."

   partner := nil.
   me := nil.
   sema := Semaphore new.
   ^self