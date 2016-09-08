RegisterAllocatingCogit is an optimizing code generator that is specialized in register allocation..

On the contrary to StackToRegisterMappingCogit, RegisterAllocatingCogit keeps at each control flow merge point the state of the simulated stack to merge into and not only an integer fixup. Each branch and jump record the current state of the simulated stack, and each fixup is responsible for merging this state into the saved simulated stack.
