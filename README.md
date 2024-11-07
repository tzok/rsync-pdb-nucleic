# rsync-pdb-nucleic

A script that first parses `pdb_entry_type.txt` to extract nucleic acid structures' ids. Then, it selectively synchronizes the mmCIF files of the whole structures and all of their assemblies to a given directory. The script uses Rsync for efficient synchronization.

The final directory requires approximately 28 GiB of space. The initial run takes around 30 minutes, contingent on network bandwidth, while subsequent runs, with the directory already populated, complete in about 2.5 minutes.
