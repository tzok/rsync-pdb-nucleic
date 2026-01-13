#! /usr/bin/env bash
BACKUP_DIR=/home/tzok/rsync-pdb-nucleic

mkdir \
	--parents \
	${BACKUP_DIR}/data/assemblies/mmCIF/divided \
	${BACKUP_DIR}/data/structures/divided/mmCIF \
	${BACKUP_DIR}/derived_data

rsync \
	--archive \
	--progress \
	rsync.ebi.ac.uk::pub/databases/pdb/derived_data/pdb_entry_type.txt \
	${BACKUP_DIR}/derived_data/pdb_entry_type.txt

pdbids=($(cat ${BACKUP_DIR}/derived_data/pdb_entry_type.txt | awk '$2 == "nuc" || $2 == "prot-nuc" { print $1 }'))

rsync \
	--archive \
	--progress \
	--delete \
	--include-from=<(printf "%s*\n" ${pdbids[@]}) \
	--include='*/' \
	--exclude='*' \
	rsync.ebi.ac.uk::pub/databases/pdb/data/assemblies/mmCIF/divided/ \
	${BACKUP_DIR}/data/assemblies/mmCIF/divided/

rsync \
	--archive \
	--progress \
	--delete \
	--include-from=<(printf "%s*\n" ${pdbids[@]}) \
	--include='*/' \
	--exclude='*' \
	rsync.ebi.ac.uk::pub/databases/pdb/data/structures/divided/mmCIF/ \
	${BACKUP_DIR}/data/structures/divided/mmCIF/
