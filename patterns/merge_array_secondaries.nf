

// used for when an array of 

nextflow.enable.dsl=2

params.data_dir = '../data'

ch_bams = Channel.fromPath("${params.data_dir}/*.bam")
ch_bais = Channel.fromPath("${params.data_dir}/*.bam.bai")

workflow {
    BUNDLE_SECONDARIES(
        ch_bams,
        ch_bais,
    )

    MERGE_ARRAY_SECONDARIES(
        BUNDLE_SECONDARIES.out.bam.collect(),
        BUNDLE_SECONDARIES.out.bai.collect()
    )
}

process BUNDLE_SECONDARIES {
    input:
    path bam
    path bai

    output:
    path bam, emit: bam 
    path bai, emit: bai

    script:
    """
    """
}

process MERGE_ARRAY_SECONDARIES {
    publishDir "./outputs", mode: 'symlink'
    input:
    path bams   // array of bams
    path bais   // array of secondary files (bais)

    output:
    path "out.bam", emit: bam 
    path "out.bam.bai", emit: bai

    script:
    // emulating a program consuming inputs and merging
    """
    cat ${bams[0]} >> out.bam
    cat ${bams[1]} >> out.bam
    cat ${bams[2]} >> out.bam
    cat ${bais[0]} >> out.bam.bai
    cat ${bais[1]} >> out.bam.bai
    cat ${bais[2]} >> out.bam.bai
    """
}