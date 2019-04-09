# Amplicon sequencing of fish ponds, guts and water (16S and LSU)

# Collaborators

 * Jason Abernathy USDA-ARS, Stuttgart, AR
 * Candis Ray USDA-ARS, Stuttgart, AR
 * Adam Rivers USDA-ARS, Gainesville, FL

# Workflow (see runall.sh for details)

 * demultiplex by header name
 * create manifest with python script
 * import into qiime2
 * visualize Quality
 * Call Sequence variants with Dada2
 * assign taxonomy
 * create Tree
 * run core diversity metrics
 * hypotheses specific analyses TBD
