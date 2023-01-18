



nextflow.enable.dsl=2

params.seq1 = 'GATTACA'
params.seq2 = 'GATAACA'

workflow {
    FILEPAIR_OUT(
        params.seq1,
        params.seq2,
    ).view()
}

process FILEPAIR_OUT {
    publishDir './outputs'

    input:
    val seq1
    val seq2

    output: 
    path "[seq1.fastq, seq2.fastq]", emit: out
    

    script:
    """
    echo ${seq1} > seq1.fastq
    echo ${seq2} > seq2.fastq
    """ 
}