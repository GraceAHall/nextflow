


params.reads = [
    '/home/grace/work/pp/translation/nextflow/data/mutant_R1.fastq',
    '/home/grace/work/pp/translation/nextflow/data/mutant_R2.fastq'
]

ch_reads = Channel.fromPath( params.reads ).toList()
ch_reads.view()

workflow {
    TASK1(ch_reads).view()
}

process TASK1 {
    
    input:
    tuple path(reads1), path(reads2)

    output: 
    stdout

    script:
    def reads_joined = reads1 + ' ' + reads2
    """
    echo ${reads_joined}
    echo --reads ${reads_joined}
    echo --reads-index-0 ${reads1}
    echo --reads-index-1 ${reads2}
    """

}