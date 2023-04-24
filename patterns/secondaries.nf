


// used when nextflow.config declares individual files making up secondary files

nextflow.enable.dsl=2

params.in_alignments_bam = '../data/aln1.sorted.bam'
params.in_alignments_bai = '../data/aln1.sorted.bam.bai'

ch_in_alignments = Channel.fromPath([
                        params.in_alignments_bam, 
                        params.in_alignments_bai
                    ])
                    .collect()

workflow {
    SECONDARIES(ch_in_alignments).view()
}

process SECONDARIES {
    input:
    tuple path(bam), path(bai)

    output:
    tuple path(bam), path(bai)

    script:
    """
    """
}