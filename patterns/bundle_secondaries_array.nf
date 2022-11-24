

// DEPRECATED  
// is this actually useful? 

nextflow.enable.dsl=2

params.bams = [
    '../data/aln1.sorted.bam',
    '../data/aln2.sorted.bam',
    '../data/aln3.sorted.bam',
]

params.bais = [
    '../data/aln1.sorted.bam.bai',
    '../data/aln2.sorted.bam.bai',
    '../data/aln3.sorted.bam.bai',
]

ch_bams = Channel.fromPath(params.bams).collect()
ch_bais = Channel.fromPath(params.bais).collect()

workflow {
    BUNDLE_SECONDARIES_ARRAY(
        ch_bams,
        ch_bais,
    ).view{ it }
}

process BUNDLE_SECONDARIES_ARRAY {
    input:
    path bams
    path bais

    output:
    tuple path(bams), path(bais)

    script:
    """
    """
}
