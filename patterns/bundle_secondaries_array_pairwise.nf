
// DEPRECATED  

nextflow.enable.dsl=2

params.data_dir = '../data'
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

ch_bams = Channel.fromPath(params.bams)
ch_bais = Channel.fromPath(params.bais)

workflow {
    BUNDLE_SECONDARIES(
        ch_bams,
        ch_bais,
    ).toList().view()
}

process BUNDLE_SECONDARIES {
    input:
    path bam
    path bai

    output:
    tuple path(bam), path(bai)

    script:
    """
    """
}