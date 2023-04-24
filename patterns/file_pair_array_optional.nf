
NULL = 'NULL'
params.NULL = 'NULL'
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
// params.reads = [
//     [
//         NULL,
//         NULL,
//     ],
//     [
//         NULL,
//         NULL,
//     ]
// ]

reads = params.reads.collect{ it.collect{ file(it) } }

workflow {
    TASK1(reads.flatten().toList()).view()
}

process TASK1 {
    
    input:
    path reads_flat, stageAs: 'reads_flat??/*'

    output: 
    stdout

    script:
    def read_pairs = reads_flat.collate(2, 1)
    def all_reads_joined = reads_flat.simpleName[0] != params.NULL ? reads_flat.join(' ') : ""
    def all_reads_joined_prefix = reads_flat.simpleName[0] != params.NULL ? "--reads " + reads_flat.join(' ') : ""
    def read_pairs_0 = read_pairs[0][0].simpleName != params.NULL ? "--read-pairs-0 " + read_pairs[0].join(' ') : "" 
    def read_pairs_1 = read_pairs[1][0].simpleName != params.NULL ? "--read-pairs-1 " + read_pairs[1].join(' ') : "" 
    def read_pairs_0_0 = read_pairs[0][0].simpleName != params.NULL ? "--read-pairs-0-0 " + read_pairs[0][0] : "" 
    def read_pairs_0_1 = read_pairs[0][1].simpleName != params.NULL ? "--read-pairs-0-1 " + read_pairs[0][1] : "" 
    """
    echo ${read_pairs}
    echo ${all_reads_joined}
    echo ${all_reads_joined_prefix}
    echo ${read_pairs_0}
    echo ${read_pairs_1}
    echo ${read_pairs_0_0}
    echo ${read_pairs_0_1}

    """

}