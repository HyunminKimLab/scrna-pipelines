
	p="hsa04110";
	s="hsa";

	library("pathview")
	d=read.table("stdin",header=T,row.names=1);
	pathview(gene.data=d, gene.idtype="symbol",pathway.id=p, species=s)
