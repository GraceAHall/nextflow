

nextflow.enable.dsl=2

params.bams = [
    '../data/aln1.sorted.bam',
    '../data/aln2.sorted.bam',
    '../data/aln3.sorted.bam',
]
params.bais = [
    '../data/aln1.sorted.bam.bai',
    '../data/aln2.sorted.bam.bai',
    '../data/aln3.sorted.bam.bai',
]

ch_bams = Channel.fromPath(params.bams)
ch_bais = Channel.fromPath(params.bais)

workflow {
    // pairwise
    // scatter.dot - [A, B, C] + [1, 2, 3] -> [A1, B2, C3]
    // each item of bams and bais sent pairwise
    SCATTER_DOT(
        ch_bams,  
        ch_bais
    )
    SCATTER_DOT.out.bam.view{ it }
    SCATTER_DOT.out.bai.view{ it }
}

process SCATTER_DOT {
    input:
    path bam
    path bai

    output:
    path(bam), emit: bam
    path(bai), emit: bai

    script:
    """
    """
}

