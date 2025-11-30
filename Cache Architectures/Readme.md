# The provided Caches
1. Direct Mapped Cache
   
A direct-mapped cache places each memory block in exactly one cache line based on its index. It is simple and fast but prone to conflict misses because multiple blocks may compete for the same line.

2. 2 way Set Associative Cache

A set-associative cache divides the cache into multiple sets, with each set containing several lines (ways). A memory block can be placed in any line within its indexed set. This reduces conflict misses while keeping hardware complexity moderate.

3. Fully Associative Cache

In a fully associative cache, a memory block can be placed in any cache line. This offers the lowest conflict misses but requires expensive hardware for searching all lines in parallel, making it slower and costlier for large caches.

# The Process of creating the Cache lines (ways) and Verification

# Downloading Files

A skeleton and a verification framework have been developed and uploaded to GitGitHub. 
This can be cloned to ease the process

git clone https://github.com/aaqdas/cache-tester.git


# Memory Initialization and Logs

Now switch to cloned directory. The directory contains several script files in **scripts** which generate memory initialization files for caches in **init_files** and log files in **log**.

**cache_init.py** is the primary script, that takes different flags and generates initialization files for different configurations of caches.  
It takes **blocks (-b)**, **words per block (-w)** and **associativity (-a)** as inputs.

python3 ./cache_init.py -b 256 -w 1 -a 1


# Simulation

Designed caches can be simulated by integrating your design in available testbench in **tb** directory.  

The simulation testbench generates a log under the name **core_access.log** in the **log** directory.

# Cache Evaluation

The cache results can be evaluated using comparison tool in **scripts** directory.  
The usage of the tool is as follows:

python3 ./check.py ../log/access.log ../log/core_access.log

