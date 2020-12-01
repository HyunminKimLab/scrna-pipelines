#!/bin/bash


usage="
usage: bash $BASH_SOURCE <input> <pathwayid> <species> 
	or
	bash $RBASH_SOURCE test 
		this will test required R libraries (pathview)
	<input>: read https://pathview.uncc.edu/tutorial#gene_data
	<pathwayid>: kegg pathway id
"
if [ $# -lt 1 ];then echo "$usage";exit; fi

input=$1
pathwayid=${2:-"hsa04110"};
species=${3:-"hsa"};
output=hsa${pathwayid/hsa}




cat << 'EOF' | sed s#PATHID#$pathwayid# \
	| sed s#SPECIES#$species# > $output.R

	p="PATHID";
	s="SPECIES";

	library("pathview")
	d=read.table("stdin",header=T,row.names=1);
	pathview(gene.data=d, gene.idtype="symbol",pathway.id=p, species=s)
EOF


if [[ $input == "test" && ! -f $input ]];then 
	sample_data="x
	MCM2	-1
	ORC1	0
	UKNOWN	1"
	echo "$sample_data" | R --no-save -f $output.R
else
	cat $input | R --no-save -f $output.R 
fi

