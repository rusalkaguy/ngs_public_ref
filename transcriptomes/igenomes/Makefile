#
# tophat reference indices for mm10 from Illumina!
#

# https://www.gnu.org/software/wget/manual/wget.html
WGET_FLAGS	= --continue --no-host-directories --no-directories --directory-prefix=. 
#WGET_FLAGS	= --continue --no-host-directories --force-directories --directory-prefix=. 

# 
# actual targets (work is here)
#

# mm10.ucsc
download_mm10_ucsc: Mus_musculus_UCSC_mm10.tar.gz.done
	tar xvf $(subst .done,,$<)

Mus_musculus_UCSC_mm10.tar.gz: | Mus_musculus_UCSC_mm10.tar.gz.done
	wget $(WGET_FLAGS) "ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Mus_musculus/UCSC/mm10/Mus_musculus_UCSC_mm10.tar.gz"
	date > $@.done

# mm10.ensembl
download_mm10_ensembl: Mus_musculus_Ensembl_NCBIM37.tar.gz.done
	tar xvf $(subst .done,,$<)

Mus_musculus_Ensembl_NCBIM37.tar.gz.done:
	wget $(WGET_FLAGS) "ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Mus_musculus/Ensembl/NCBIM37/Mus_musculus_Ensembl_NCBIM37.tar.gz"
	date > $@

# hg19/b37.ensemble
download_hg37_ensembl: Homo_sapiens_Ensembl_GRCh37.tar.gz.done
	tar xvf $(subst .done,,$<)

Homo_sapiens_Ensembl_GRCh37.tar.gz.done:
	wget $(WGET_FLAGS) "ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Homo_sapiens/Ensembl/GRCh37/Homo_sapiens_Ensembl_GRCh37.tar.gz"
	date > $@

# hg19/b37.ucsc
download_hg19_ucsc: Homo_sapiens_UCSC_hg19.tar.gz.done
	tar xvf $(subst .done,,$<)

Homo_sapiens_UCSC_hg19.tar.gz.done: 
	wget $(WGET_FLAGS) "ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Homo_sapiens/UCSC/hg19/Homo_sapiens_UCSC_hg19.tar.gz"
	date > $@


# hg38.ucsc
download_hg38_ucsc: Homo_sapiens_UCSC_hg38.tar.gz.done 
	tar xvf $(subst .done,,$<)

Homo_sapiens_UCSC_hg38.tar.gz.done:
	wget $(WGET_FLAGS) "ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Homo_sapiens/UCSC/hg38/Homo_sapiens_UCSC_hg38.tar.gz"
	date > $@


# hg38decoy.ncbi
download_hg38decoy_ncbi: Homo_sapiens_NCBI_GRCh38Decoy.tar.gz.done
	tar xvf $(subst .done,,$<)

Homo_sapiens_NCBI_GRCh38Decoy.tar.gz.done:
	wget $(WGET_FLAGS) "ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Homo_sapiens/NCBI/GRCh38Decoy/Homo_sapiens_NCBI_GRCh38Decoy.tar.gz"
	date > $@.done

#
# qsub make of targets
#
qsub: qsub_mm10_ucsc qsub_mm10_ensembl qsub_hg37_ensembl qsub_hg19_ucsc qsub_hg38_ucsc qsub_hg38decoy_ncbi

qsub_%: 
	qsub -N wget_$* -l h_rt=23:00:00,s_rt=23:00:00,vf=1,h_vmem=1G -cwd -V -m beas -M $(USER)@uab.edu -j y -b yes $$(which make) $(MFLAGS) download_$*
	nohup qstat_email_when_empty wget_$* &

#
# debug
#
info: 
	@echo MAKE=$(MAKE)
	@echo MFLAGS=$(MFLAGS)
	@echo WGET_FLAGS=$(WGET_FLAGS)
