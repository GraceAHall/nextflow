

nextflow.enable.dsl=2

ch_ref = Channel.fromPath('../data/wildtype.fna')

workflow {
    STAGE_AS(ch_ref).view()
}

process STAGE_AS {
    publishDir './outputs'

    input:
    path pos_basic, stageAs: 'frank.fna'

    output: 
    stdout

    script:
    """
    cat ${pos_basic}
    """ 
}