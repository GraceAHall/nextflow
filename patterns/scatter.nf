

nextflow.enable.dsl=2

params.bams = [
    '../data/aln1.sorted.bam',
    '../data/aln2.sorted.bam',
    '../data/aln3.sorted.bam',
]

ch_bams = Channel.fromPath(params.bams)

workflow {
    SCATTER(
        ch_bams // scatter is implicit in nextflow
    )
}

process SCATTER {
    input:
    path bam

    output:
    path(bam)

    script:
    """
    """
}
