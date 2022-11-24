

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
ch_arrays = Channel.of()
            .concat(ch_bams)
            .concat(ch_bais)

workflow {
    SCATTER_ARRAY(
        ch_arrays // each array in ch_arrays fed one at a time
    )
    // .view{ it }
}

process SCATTER_ARRAY {
    input:
    path files

    output:
    path(files)

    script:
    """
    """
}