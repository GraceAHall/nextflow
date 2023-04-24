

// PARAMS
params.my_str       = 'hello'
params.my_str_arr   = ['hello', 'there']

params.my_file      = '/home/grace/work/pp/translation/nextflow/data/alignments.sam'
params.my_secondary  = [
    '/home/grace/work/pp/translation/nextflow/data/aln1.sorted.bam',
    '/home/grace/work/pp/translation/nextflow/data/aln1.sorted.bam.bai',
]

params.my_file_arr  = [
    '/home/grace/work/pp/translation/nextflow/data/mutant_R1.fastq',
    '/home/grace/work/pp/translation/nextflow/data/mutant_R2.fastq',
]
params.my_secondary_arr  = [
    [
        '/home/grace/work/pp/translation/nextflow/data/aln2.sorted.bam',
        '/home/grace/work/pp/translation/nextflow/data/aln2.sorted.bam.bai',
    ]
]

// params.my_str_opt           = null
// params.my_str_arr_opt       = null
// params.my_file_opt          = null
// params.my_file_arr_opt      = null
// params.my_secondary_opt     = null
// params.my_secondary_arr_opt = null

// params.my_str_opt           = null
// params.my_str_arr_opt       = []

params.my_file_opt          = 'no_file1'
params.my_file_arr_opt      = ['no_file2', 'no_file3']
params.my_secondary_opt     = ['no_file4', 'no_file5']
params.my_secondary_arr_opt = [['no_file6', 'no_file7']]


// CHANNELS
ch_my_file              = Channel.fromPath( params.my_file )
ch_my_file_arr          = Channel.fromPath( params.my_file_arr ).toList()
ch_my_secondary         = Channel.fromPath( params.my_secondary ).toList()
ch_my_secondary_arr     = Channel.fromPath( params.my_secondary_arr.flatten() ).buffer( size: 2 ).toList()

ch_my_file_opt              = Channel.fromPath( params.my_file_opt )
ch_my_file_arr_opt          = Channel.fromPath( params.my_file_arr_opt ).toList()
ch_my_secondary_opt         = Channel.fromPath( params.my_secondary_opt ).toList()
ch_my_secondary_arr_opt     = Channel.fromPath( params.my_secondary_arr_opt.flatten() ).buffer( size: 2 ).toList()


workflow {
    // ch_my_file.view{ 'ch_my_file: ' + it }
    // ch_my_file_arr.view{ 'ch_my_file_arr: ' + it }
    // ch_my_secondary.view{ 'ch_my_secondary: ' + it }
    // ch_my_secondary_arr.view{ 'ch_my_secondary_arr: ' + it }
    
    ch_my_file_opt.view{ 'ch_my_file_opt: ' + it }
    ch_my_file_arr_opt.view{ 'ch_my_file_arr_opt: ' + it }
    ch_my_secondary_opt.view{ 'ch_my_secondary_opt: ' + it }
    ch_my_secondary_arr_opt.view{ 'ch_my_secondary_arr_opt: ' + it }
    
    // TASK_MANDATORY(
    //     ch_my_file,
    //     ch_my_file_arr,
    //     ch_my_secondary,
    //     ch_my_secondary_arr.flatten().toList(),
    // )
    // TASK_MANDATORY.out.view()
    
    TASK_OPTIONAL(
        ch_my_file_opt,
        ch_my_file_arr_opt,
        ch_my_secondary_opt,
        ch_my_secondary_arr_opt.flatten(),
    )
    TASK_OPTIONAL.out.view()

}

process TASK_MANDATORY {
    input: 
    path my_file
    path my_file_arr
    tuple path(bam), path(bai)
    path my_secondary_arr_flat

    output:
    stdout

    script:
    def my_file_arr = my_file_arr.join(' ')
    def my_secondary = bam + ' ' + bai
    def my_secondary_arr_flat = my_secondary_arr_flat.join(' ')
    """
    echo my_file:               ${my_file}
    echo my_file_arr:           ${my_file_arr}
    echo my_secondary:          ${my_secondary}
    echo my_secondary_arr_flat: ${my_secondary_arr_flat}
    """

}

process TASK_OPTIONAL {
    input: 
    path my_file_opt
    path my_file_arr_opt
    tuple path(bam_opt), path(bai_opt)
    path my_secondary_arr_opt_flat

    output:
    stdout

    script:
    def my_file_opt = my_file_opt != 'no_file1' ? my_file_opt : ''
    def my_file_arr_opt = my_file_arr_opt != ['no_file2', 'no_file3'] ? my_file_arr_opt : ''
    def bam_opt = bam_opt ? bam_opt != 'no_file4' : ''
    def bai_opt = bai_opt ? bai_opt != 'no_file5' : ''
    def my_secondary_arr_opt_flat = my_secondary_arr_opt_flat != ['no_file6', 'no_file7'] ? my_secondary_arr_opt_flat : ''
    """
    echo my_file_opt:                ${my_file_opt}
    echo my_file_arr_opt:            ${my_file_arr_opt}
    echo my_secondary_opt[0]:        ${bam_opt}
    echo my_secondary_opt[1]:        ${bai_opt}
    echo my_secondary_arr_opt_flat:  ${my_secondary_arr_opt_flat}
    """

}
