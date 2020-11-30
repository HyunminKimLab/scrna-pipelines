#!/bin/bash

usage="$BASH_SOURCE <input> <pathwayid> <species> <outdir>
"
if [ $# -lt 1 ];then echo "$usage";exit; fi

input=$1
pathwayid=${2:-"hsa04110"};
species=${3:-"hsa"};
outdir=${4:-"pathway_out"}; outdir=${outdir/\/$/}


sample_data="MCM2	-1
ORC1	0
UKNOWN	1"

mkdir -p $outdir

cat << 'EOF' | sed s#PATHID#$pathwayid# \
	| sed s#SPECIES#$species# \
	| sed s#OUTDIR#$outdir# > $outdir/code.R

	p="PATHID";
	s="SPECIES";
	o="OUTDIR";

	library("pathview")
	d=read.table("stdin",header=F);
	head(d)
	x=d[,2]; names(x)=d[,1]
	head(x)
	pathview(gene.data=x, kegg.dir=o,gene.idtype="symbol",pathway.id=p, species=s)
EOF


if [[ $input == "test" && ! -f $input ]];then 
	echo "$sample_data" | R --no-save -f $outdir/code.R
else
	cat $input | R --no-save -f $outdir/code.R 
fi
if [ -f ./$pathwayid.pathview.* ];then
	mv ./$pathwayid.pathview.* $outdir
fi

