# Tableau

### [Column-Oriented Database Systems](http://nms.csail.mit.edu/~stavros/pubs/tutorial2009-column_stores.pdf)
- Row-store have all associated data in a tuple, making it easy to add/modify records
- Column-stores have all data points as separate entries, storing them individually meaning we won't make unecessary reads
- provides heavy optimization for complex queries on wide databases
  - less reads since we might only read a few columns instead of hundreds
  - column-stores can optimize for compression (more consistent formatting so less entropy)
  - sorted columns compress better, range queries are faster (since the data can be stored sequentially)
  - performance benefits from clustered indexing

### Tableau Extracts
Tableau Data Extracts are a compressed set of files that represent a data table from our data source, for the purpose of visualization in Tableau.
- TDE's are heavily optimized to work with large datasets using low RAM and reduced Disk
- TDE's have a file for each column (file of data elements) + metadata file(s)
- TDE is a single file that contains many individual [memory-mapped files](https://en.wikipedia.org/wiki/Memory-mapped_file), composed of column and metadata files
- compression is not general file compression, it's run length encoding and dictionary compression so no need for decompression when loading into memory

Compressed snapshot of data stored on disk - saved subsets of data sources for performance optimization
- can add functionality to data filtering
- extracts can perform full refreshes or incremental refreshes that add rows that are new since the previous refresh
- when a data extract is created, the structure for the extract is first defined, with a searate file for each column in the underling source
- TDE compression is separate from file compression, no decompression to load into memory
  - uses dictionar compression and run length encoding

### Optimization
- network speeds between machines are a bottleneck
- server hosted extracts will be faster
- Individual row pull speed may still be an issue, depending on the query setup (Subqueries in the SELECT items, for example). Try landing the data to a table temporarily (or permanently, reloaded with an sproc)  to see the speed difference.
- Bringing down the number of columns, **especially text columns** will definitely speed up the query significantly.
