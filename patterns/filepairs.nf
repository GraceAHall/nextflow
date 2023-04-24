


params.fastqgzpair = [
    '/home/grace/work/pp/translation/nextflow/data/mutant_R1.fastq',
    '/home/grace/work/pp/translation/nextflow/data/mutant_R2.fastq'
]

params.fastqgzpair_array = [
    [
        '/home/grace/work/pp/translation/nextflow/data/mutant_R1.fastq',
        '/home/grace/work/pp/translation/nextflow/data/mutant_R2.fastq'
    ]
]

// ch_fastqgzpair = Channel.fromPath( params.fastqgzpair ).toList()
// ch_fastqgzpair_array = Channel.fromPath( params.fastqgzpair_array.flatten() ).buffer( size: 2 )

ch_fastqgzpair = Channel.fromFilePairs( params.fastqgzpair )
// ch_fastqgzpair_array = Channel.fromFilePairs( params.fastqgzpair_array )


workflow {
    // ch_fastq_pair_array.view()
    TEST(ch_fastqgzpair).view()
    // TEST(ch_fastqgzpair_array).view()
}


process TEST {
    input:
    path fastq

    output: 
    stdout

    script:
    def fastq = fastq.join(' ')
    """
    echo ${fastq}
    """

}