#!/bin/bash
#
# download NCBI blast dbs into date-stamped directories 
#
#$ -l h_rt=72:00:00
#$ -l vf=2G
#$ -m beas -M curtish@uab.edu
#$ -N wget_ncbi_blast_dbs

NCBI_FTP=ftp://ftp.ncbi.nlm.nih.gov/blast/db/ 

# check optional date parameter
if [[ "$1" == ????-??-?? ]]; then
	ISO_DATE_STR=$1
fi
if [[ "$ISO_DATE_STR" == ????-??-?? ]]; then 
	echo "ISO_DATE_STR=$ISO_DATE_STR"
else
	echo "SYNTAX: $0 ISO_DATE_STR "
	echo "Date FORMAT MUST BE YYYY-MM-DD"
	echo "check $NCBI_FTP for latest correct date"
	exit 1
fi

#DATE_STR=`date +"%Y %b %d"`
#ISO_DATE_STR=`date +"%Y-%m-%d"`
TARGET_DIR=/scratch/share/public_datasets/ngs/databases/blast/$ISO_DATE_STR

for db in refseq_genomic refseq_protein nr nt 16SMicrobial env_nr env_nt; do
    echo "DB: $db"
    DB_DIR=$TARGET_DIR/$db
    echo "DIR: $DB_DIR"
    mkdir -p $DB_DIR
    pushd $DB_DIR
    # -c to keep files already download - no date checking!
    # -nv non-
    wget --no-verbose "$NCBI_FTP/${db}.*" 
    RC=$?
    if [ $RC != 0 ]; then 
	echo "ERROR[rc=$RC]: wget --no-verbose \"$NCBI_FTP/${db}.*\""
	exit $RC >/dev/null 2>&1 
    fi
    date > wget.done
    popd
done

# parallel md5 check
q_rcmd .md5 "md5sum -c " .md5.out $TARGET_DIR

# launch parallel decompress & untar
q_rcmd .tar.gz "tar xzvf "  $TARGET_DIR

# cleanup 
#lfs find . -name "q_*" | xargs rm -rf
#lfs find . -name "*.tar" | xargs rm -rf
#lfs find . -name "*.tar.gz" | xargs rm -rf
#lfs find . -name "*.md5*" | xargs rm -rf

exit 0 >/dev/null 2>&1 
