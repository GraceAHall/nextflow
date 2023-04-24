

params.fasta = '/home/grace/work/pp/translation/nextflow/data/wildtype.fna'
params.fastq_pair = [
    '/home/grace/work/pp/translation/nextflow/data/mutant_R1.fastq',
    '/home/grace/work/pp/translation/nextflow/data/mutant_R2.fastq',
]

params.bam_bai_array = [
    [
        '/home/grace/work/pp/translation/nextflow/data/aln1.sorted.bam', 
        '/home/grace/work/pp/translation/nextflow/data/aln1.sorted.bai'
    ],
    [
        '/home/grace/work/pp/translation/nextflow/data/aln2.sorted.bam', 
        '/home/grace/work/pp/translation/nextflow/data/aln2.sorted.bai'
    ],
]

fasta = file( params.fasta )
fastq_pair = [file( params.fastq_pair[0] ), file( params.fastq_pair[1] )]

ch_fasta = Channel.fromPath( params.fasta )
ch_fastq_pair = Channel.fromPath( params.fastq_pair.flatten() ).buffer( size: 2 ).toList()
ch_bam_bai_array = Channel.fromPath( params.bam_bai_array.flatten() ).buffer( size: 2 ).toList()


workflow {
    // ch_bam_bai_array.view()

    TASK1(
        fasta,
        fastq_pair,
        ch_bam_bai_array.flatten().buffer( size: 2)
    )
    TASK1.out.view()
    // TASK1(
    //     ch_fasta,
    //     ch_fastq_pair.flatten().buffer( size: 2),
    //     ch_bam_bai_array.flatten().buffer( size: 2)
    // )
    // TASK1.out.view()
    // SUB1(
    //     ch_fasta,
    //     ch_fastq_pair,
    //     ch_bam_bai_array
    // )
    // SUB1.out.view()

}


workflow SUB1 {
    take:
    ch_fasta
    ch_fastq_pair
    ch_bam_bai

    main:

    TASK1(
        ch_fasta,
        ch_fastq_pair,
        ch_bam_bai,
    )

    emit: 
    out = TASK1.out

}


process TASK1 {

    input:
    path fasta 
    path fastq_pair 
    tuple path(bam), path(bai)

    output: 
    stdout

    script: 
    """
    echo ${fasta} ${fastq_pair} ${bam} ${bai}
    """

}