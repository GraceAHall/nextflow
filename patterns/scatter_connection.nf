

nextflow.enable.dsl=2

params.files = ['../data/wildtype.fna', '../data/wildtype.fna.amb']
ch_files = Channel.fromPath(params.files)

// // singles -> singles
// workflow {
//     COMPONENTS1(ch_files)
//     COMPONENTS2(COMPONENTS1.out.out)
//     COMPONENTS2.out.out.view()
// }

// array -> singles
workflow {
    COMPONENTS1_ARRAY(ch_files.collect())
    COMPONENTS2(COMPONENTS1_ARRAY.out.out.flatten)
    COMPONENTS2.out.out.view()
}

process COMPONENTS1 {
    publishDir './outputs'

    input:
    path file

    output: 
    path file, emit: out

    script:
    """
    """
}

process COMPONENTS1_ARRAY {
    publishDir './outputs'

    input:
    path files

    output: 
    path files, emit: out

    script:
    """
    """
}

process COMPONENTS2 {
    publishDir './outputs'

    input:
    path file

    output: 
    path file, emit: out

    script:
    """
    """
}