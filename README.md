# scrna-pipelines
We are developing linux-runnable pipelines

## Default RNA-seq pipeline runs
- RSEM | edgeR or DESeq2 | GSEA

## Default scRNA-seq pipeline runs
- Cellranger | integration (Harmony) | visualization clustering (Seurat) | cell/function identification 
- many functional analysis solutions of RNA-seq are reusable in scRNA

## Pathway Visualization
```
## R wrapper is tested with sample data
## the first row include only column names
bash pathview.sh test

## this is api read details
## source: https://pathview.uncc.edu/api_tutorial
bash pathviewapi.sh --help
```
