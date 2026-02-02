#! /usr/bin/env bash
set -x

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

pdbids_file=$(mktemp)
cat ${BACKUP_DIR}/derived_data/pdb_entry_type.txt | awk '$2 == "nuc" || $2 == "prot-nuc" { print $1 "*" }' > "$pdbids_file"

rsync \
	--archive \
	--progress \
	--stats \
	--delete \
	--delete-excluded \
	--include-from="$pdbids_file" \
	--include='*/' \
	--exclude='*' \
	rsync.ebi.ac.uk::pub/databases/pdb/data/assemblies/mmCIF/divided/ \
	${BACKUP_DIR}/data/assemblies/mmCIF/divided/

rsync \
	--archive \
	--progress \
	--stats \
	--delete \
	--delete-excluded \
	--include-from="$pdbids_file" \
	--include='*/' \
	--exclude='*' \
	rsync.ebi.ac.uk::pub/databases/pdb/data/structures/divided/mmCIF/ \
	${BACKUP_DIR}/data/structures/divided/mmCIF/

rm "$pdbids_file"
