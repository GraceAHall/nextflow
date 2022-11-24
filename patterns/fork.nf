


nextflow.enable.dsl=2

ch_ref = Channel.fromPath('../data/wildtype.fna')

workflow {
    FOO(ch_ref).view()
    BAR(ch_ref).view()
}

process FOO {
    input:
    path pos_basic

    output: 
    path pos_basic

    script:
    """
    """ 
}

process BAR {
    input:
    path pos_basic

    output: 
    path pos_basic

    script:
    """
    """ 
}