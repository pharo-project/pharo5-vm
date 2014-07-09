A benchmark harness steers the execution and reporting of benchmarks.
For that purpose, it will use a designated benchmark runner to do the execution and a benchmark reporter to output the results.
The benchmark harness is also parameterized by the benchmark suites that are to be executed.

The simplest way to execute a benchmark suite is to use SMarkSuite >> #run.

However, directly using the harness classes gives more freedom on reporting and execution strategies.

A typical call of the harness from the commandline would result in the following invokation:
	SMarkHarness run: {'SMarkHarness'. 'SMarkLoops.benchIntLoop'. 1. 1. 5}