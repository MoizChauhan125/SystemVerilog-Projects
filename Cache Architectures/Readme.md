# Downloading Files

A skeleton and a verification framework have been developed and uploaded to GitGitHub.  
The students are required to clone the repository from:

git clone https://github.com/aaqdas/cache-tester.git


# Memory Initialization and Logs

Now switch to cloned directory. The directory contains several script files in **scripts** which generate memory initialization files for caches in **init_files** and log files in **log**.

**cache_init.py** is the primary script, that takes different flags and generates initialization files for different configurations of caches.  
It takes **blocks (-b)**, **words per block (-w)** and **associativity (-a)** as inputs.

python3 ./cache_init.py -b 256 -w 1 -a 1


# Simulation

Designed caches can be simulated by integrating your design in available testbench in **tb** directory.  
The simulations **must be run in Xcelium** to prevent issues in porting.

The simulation testbench generates a log under the name **core_access.log** in the **log** directory.

# Cache Evaluation

The cache results can be evaluated using comparison tool in **scripts** directory.  
The usage of the tool is as follows:

python3 ./check.py ../log/access.log ../log/core_access.log
