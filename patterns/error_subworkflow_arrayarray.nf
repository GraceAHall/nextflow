

nextflow.enable.dsl=2


params.filename = 'hello.txt'



workflow {
    STEP1(params.filename)
    // STEP2_ERROR(
    //     STEP1.out.out1,
    //     STEP1.out.out2
    // )
    STEP2_SOLUTION(
        STEP1.out.out1,
        STEP1.out.out2
    )
}

workflow SUBWF {

    take:
    ch_sortsam_tmp_dir
    ch_three_prime_adapter_read1
    ch_three_prime_adapter_read2
    ch_reference
    ch_fastq
    ch_sample_name

    main:
    ch_sortsam_tmp_dir.view{ 'ch_sortsam_tmp_dir: ' + it}
    ch_three_prime_adapter_read1.view{ 'ch_three_prime_adapter_read1: ' + it}
    ch_three_prime_adapter_read2.view{ 'ch_three_prime_adapter_read2: ' + it}
    ch_reference.view{ 'ch_reference: ' + it}
    ch_fastq.view{ 'ch_fastq: ' + it}
    ch_sample_name.view{ 'ch_sample_name: ' + it}
    
    STP1(
        ch_fastq,
        ch_sample_name,
        ch_three_prime_adapter_read1,
        ch_three_prime_adapter_read2
    )

    emit:
    out = STP1.out.out


}

process STEP1 {
    input:
    val filename

    output:
    path "dir1/${filename}", emit: out1
    path "dir2/${filename}", emit: out2

    script:
    """
    mkdir dir1
    mkdir dir2
    touch dir1/${filename}
    touch dir2/${filename}
    """
}

process STEP2_ERROR {
    input: 
    path inp1
    path inp2

    output:

    script:
    """
    echo ${inp1}
    echo ${inp2}
    """

}

process STEP2_SOLUTION {
    input: 
    path inp1, stageAs: 'inp1.txt'
    path inp2, stageAs: 'inp2.txt'

    output:

    script:
    """
    echo ${inp1}
    echo ${inp2}
    """

}