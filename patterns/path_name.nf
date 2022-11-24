

nextflow.enable.dsl=2

ch_ref = Channel.fromPath('../data/wildtype.fna')

workflow {
    NAME(ch_ref).view()
}

process NAME {
    publishDir './outputs'

    input:
    path pos_basic, name: 'frank.fna'

    output: 
    stdout

    script:
    """
    cat ${pos_basic}
    """ 
}