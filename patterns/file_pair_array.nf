


params.reads = [
    [
        '/home/grace/work/pp/translation/nextflow/data/mutant_R1.fastq',
        '/home/grace/work/pp/translation/nextflow/data/mutant_R2.fastq'
    ],
    [
        '/home/grace/work/pp/translation/nextflow/data/mutant_R3.fastq',
        '/home/grace/work/pp/translation/nextflow/data/mutant_R4.fastq'
    ]
]

ch_reads = Channel.fromPath( params.reads.flatten() ).collate( 2 )

workflow {
    TASK1(ch_reads.flatten().toList()).view()
}

process TASK1 {
    
    input:
    path reads_flat

    output: 
    stdout

    script:
    def read_pairs = reads_flat.collate(2, 1)
    def all_reads_joined = reads_flat.join(' ')
    """
    echo ${all_reads_joined}
    echo ${read_pairs}
    echo --all-reads ${all_reads_joined}
    echo --read-pairs-0 ${read_pairs[0]}
    echo --read-pairs-1 ${read_pairs[1]}
    """

}