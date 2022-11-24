

nextflow.enable.dsl=2

params.files = ['../data/wildtype.fna', '../data/wildtype.fna.amb']
ch_files = Channel.fromPath(params.files).collect()

workflow {
    COMPONENTS_ARRAY1(ch_files)
    COMPONENTS_ARRAY2(COMPONENTS_ARRAY1.out.outs)
    COMPONENTS_ARRAY2.out.outs.view()
}

process COMPONENTS_ARRAY1 {
    publishDir './outputs'

    input:
    path files

    output: 
    path files, emit: outs

    script:
    """
    """
}

process COMPONENTS_ARRAY2 {
    publishDir './outputs'

    input:
    path files

    output: 
    path files, emit: outs

    script:
    """
    """
}