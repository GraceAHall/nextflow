

NULL = 'NULL'
params.NULL = 'NULL'
params.reads = [
    '/home/grace/work/pp/translation/nextflow/data/mutant_R1.fastq',
    '/home/grace/work/pp/translation/nextflow/data/mutant_R2.fastq'
]
// params.reads = [
//     NULL,
//     NULL
// ]

reads = params.reads.collect{ file(it) }

workflow {
    TASK1(reads).view()
}

process TASK1 {
    
    input:
    tuple path(reads1, stageAs: 'reads1/*'), path(reads2, stageAs: 'reads2/*')

    output: 
    stdout

    script:
    def reads_joined = reads1.simpleName != params.NULL ? reads1 + ' ' + reads2 : ""
    def reads_joined_prefix = reads1.simpleName != params.NULL ? "--reads " + reads1 + ' ' + reads2 : "" 
    def reads1 = reads1.simpleName != params.NULL ? "-1 " + reads1 : "" 
    def reads2 = reads2.simpleName != params.NULL ? "-2 " + reads2 : "" 
    """
    echo ${reads_joined}
    echo ${reads_joined_prefix}
    echo ${reads1}
    echo ${reads2}
    """

}