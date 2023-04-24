

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