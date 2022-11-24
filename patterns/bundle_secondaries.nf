


// used when nextflow.config declares individual files making up secondary files

nextflow.enable.dsl=2

params.bam = '../data/aln1.sorted.bam'
params.bai = '../data/aln1.sorted.bam.bai'

ch_bam = Channel.fromPath(params.bam)
ch_bai = Channel.fromPath(params.bai)




workflow {
    BUNDLE_SECONDARIES(
        ch_bam,
        ch_bai,
    ).view{ it }
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