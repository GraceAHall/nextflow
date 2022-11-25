

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
    // every combination
    // scatter.cross - [A, B] + [1, 2, 3]
    // -> [A1, A2, A3, B1, B2, B3]
    ch_cross =  ch_bams
                .combine(ch_bais)
                .multiMap { it ->
                    bams: it[0]
                    bais: it[1]
                }
                .set { cartesian_cross }

    SCATTER_CROSS(
        cartesian_cross.bams,
        cartesian_cross.bais
    ).view()

}

process SCATTER_CROSS {
    input:
    path bam
    path bai

    output:
    tuple path(bam), path(bai)

    script:
    """
    """
}


