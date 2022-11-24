


// 

nextflow.enable.dsl=2

params.data_dir = '../data'
ch_bams = Channel.fromPath("${params.data_dir}/*.bam")

workflow {
    MERGE_ARRAY(
        ch_bams.collect(),
    )
}

process MERGE_ARRAY {
    publishDir "./outputs", mode: 'symlink'
    
    input:
    path bams   // array of bams

    output:
    path "out.bam", emit: bam 

    script:
    // emulating a program consuming inputs and merging
    """
    cat ${bams[0]} >> out.bam
    cat ${bams[1]} >> out.bam
    cat ${bams[2]} >> out.bam
    """
}