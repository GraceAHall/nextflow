


nextflow.enable.dsl=2

params.filepair = [
    '/home/grace/work/pp/translation/nextflow/data/mutant_R1.fastq',
    '/home/grace/work/pp/translation/nextflow/data/mutant_R2.fastq',
]
ch_filepair = Channel.fromPath( params.filepair ).toList()

workflow {
    FMT1(ch_filepair)
    FMT1.out.view()
    FMT2(ch_filepair)
    FMT2.out.view()
    FMT3(ch_filepair)
    FMT3.out.view()
}

process FMT1 {
    publishDir './outputs'

    input:
    path reads

    output: 
    path reads, emit: out
    
    script:
    """
    echo ${reads} 
    """ 
}


process FMT2 {
    publishDir './outputs'

    input:
    tuple path(reads1), path(reads2)

    output: 
    tuple path(reads1), path(reads2), emit: out
    
    script:
    """
    echo ${reads1} 
    echo ${reads2} 
    """ 
}


process FMT3 {
    publishDir './outputs'

    input:
    path reads

    output: 
    tuple path("${reads[0]}"), path("${reads[1]}"), emit: out
    
    script:
    """
    echo ${reads[0]} 
    echo ${reads[1]} 
    """ 
}