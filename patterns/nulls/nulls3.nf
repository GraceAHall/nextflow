

nextflow.enable.dsl=2


process OPTIONAL_INPUT_TYPES_TEST_TOOL {
    debug true
    container "ubuntu:latest"
    publishDir "${params.outdir}/optional_input_types_test_tool"

    input:
    path indexed_bam_flat, stageAs: 'indexed_bam_flat??/*'
    tuple path(bam, stageAs: 'bam/*'), path(bai, stageAs: 'bai/*')
    path in_file_pair_array, stageAs: 'in_file_pair_array??/*'
    path in_file_pair, stageAs: 'in_file_pair/*'
    path in_file_array, stageAs: 'in_file_array/*'
    path in_file, stageAs: 'in_file/*'
    val in_int_array
    val in_str_array
    val in_int
    val in_str

    output:
    stdout, emit: out

    script:
    def in_secondary_array = get_primary_files(indexed_bam_flat)
    def in_secondary_array_joined = in_secondary_array[0].simpleName != params.NULL ? in_secondary_array.join(' ') : ""
    def in_secondary = bam.simpleName != params.NULL ? bam : ""
    def in_file_pair_array_joined = in_file_pair_array[0].simpleName != params.NULL ? in_file_pair_array.join(' ') : ""
    def in_file_pair_joined = in_file_pair[0].simpleName != params.NULL ? in_file_pair.join(' ') : ""
    def in_file_array_joined = in_file_array[0].simpleName != params.NULL ? in_file_array.join(' ') : ""
    def in_file = in_file.simpleName != params.NULL ? in_file : ""
    def in_int_array_joined = in_int_array != params.NULL ? in_int_array.join(' ') : ""
    def in_int = in_int != params.NULL ? in_int : ""
    def in_str_array_joined = in_str_array != params.NULL ? in_str_array.join(' ') : ""
    def in_str = in_str != params.NULL ? in_str : ""
    """
    echo \
    ${in_secondary_array_joined} \
    ${in_secondary} \
    ${in_file_pair_array_joined} \
    ${in_file_pair_joined} \
    ${in_file_array_joined} \
    ${in_file} \
    ${in_int_array_joined} \
    ${in_int} \
    ${in_str_array_joined} \
    ${in_str} \
    """

}