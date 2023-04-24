

nextflow.enable.dsl=2

params.outdir       = './output'
// params.kmers        = []
// params.kmers_arr    = [[]]
// params.kmers        = null
// params.kmers_arr    = null
// params.kmers        = 'null_val'
// params.kmers_arr    = 'null_val'
params.kmers        = 'GATTACA'
params.kmers_arr    = ['GATTACA']

def nullFile = 'null_file'


workflow {
    // TASK1()
    TASK2(
        params.kmers,
        params.kmers_arr
    )
}

process TASK1 {
    input:

    output:
    stdout

    script: 
    println params.kmers ? 'kmers: TRUE' : 'kmers: FALSE'
    println params.kmers_arr ? 'kmers_arr: TRUE' : 'kmers_arr: FALSE'

    """
    """
}

process TASK2 {
    input:
    val kmers
    val kmers_arr

    output:
    stdout

    script: 
    println kmers != 'null_val' ? 'kmers: TRUE' : 'kmers: FALSE'
    println kmers_arr != 'null_val' ? 'kmers_arr: TRUE' : 'kmers_arr: FALSE'
    """
    """
}