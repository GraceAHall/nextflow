


// used when nextflow.config declares individual files making up secondary files

nextflow.enable.dsl=2

params.in_alignments_bams = [
    '../data/aln1.sorted.bam',
    '../data/aln2.sorted.bam',
    '../data/aln3.sorted.bam'
]
params.in_alignments_bais = [
    '../data/aln1.sorted.bam.bai',
    '../data/aln2.sorted.bam.bai',
    '../data/aln3.sorted.bam.bai'
]
ch_bams = Channel.fromPath(params.in_alignments_bams).collect()
ch_bais = Channel.fromPath(params.in_alignments_bais).collect()

workflow {
    SECONDARIES_ARRAY(
        ch_bams,
        ch_bais,
    )
    SECONDARIES_ARRAY.out.bams.view()
    SECONDARIES_ARRAY.out.bais.view()
}

process SECONDARIES_ARRAY {
    input:
    path bams
    path bais

    output:
    path bams, emit: bams
    path bais, emit: bais

    script:
    """
    """
}