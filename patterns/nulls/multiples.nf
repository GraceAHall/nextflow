

nextflow.enable.dsl=2

params.kmers        = 'GATTACA'
params.kmers_arr    = ['GATTACA']
// params.kmers_arr    = params.NULL
// params.kmers        = params.NULL

workflow {
    TASK1(
        params.kmers_arr,
        params.kmers
    )
}

process TASK1 {
    input:
    val kmers_arr
    val kmers

    output:
    stdout

    script: 
    println kmers_arr != params.NULL ? 'kmers_arr: TRUE' : 'kmers_arr: FALSE'
    println kmers != params.NULL ? 'kmers: TRUE' : 'kmers: FALSE'
    """
    """
}