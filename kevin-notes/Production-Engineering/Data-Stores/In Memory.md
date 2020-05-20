# In-memory Data Stores

## Redis
Redis is a data store, useful for simplifying a system, increasing responsiveness, and capable of working in addition to other SQL and NoSQL servers.

Redis is a data structures server, using key-value storage format (like hashes) with support for different types of values. Redis can hold more complex data structures than regular key-value stores.

### Advantages of Redis 
- It doesn't have to replace elements of the current tech stack, it can be **added to the current stack**. 
- Disk persistent memory makes data retrieval much faster than SQL and NoSQL data stores.

[source](http://oldblog.antirez.com/post/take-advantage-of-redis-adding-it-to-your-stack.html)

## Memcached 
Memory object caching system.
- speeds up dynamic web applications 
  - lightening database loads
- in-memory key-value store for small database and api calls, or page rendering
- allows you to make better use of available cache space from multiple web servers
  - done by combining the cache size of multiple servers into one combined cache

![diagram](https://memcached.org/memcached-usage.png)

### What is it made up of
- client software, which is given a list of available memcached servers
- client-based hashing algorithm which chooses a server based on the "key"
- server software, stores values with their keys into a hash table
- LRU (algorithm), which determines when to discard old memory

Half server, half client logic
- clients choose which server to read and write from 
- servers manage storage and implement LRU
- servers are unaware of each other 

### Memcached vs Redis
Both in memory key/val lookup tables, for high speed/availability.
- both cluster, add in memory objects without needing to reference a data store
- comparable access speeds
- past a single instance, they have different deployed and scaled architectures
