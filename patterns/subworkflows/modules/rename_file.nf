

// params.new_filename = 'hello'

process RENAME_FILE {
    input:
    path input_file

    output: 
    path "${params.new_filename}"

    script: 
    """
    cat ${input_file} > ${params.new_filename}
    """

}