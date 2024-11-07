# rsync-pdb-nucleic

A script that first parses `pdb_entry_type.txt` to extract nucleic acid structures' ids. Then, it selectively synchronizes the mmCIF files of the whole structures and all of their assemblies to a given directory. The script uses Rsync for efficient synchronization.
