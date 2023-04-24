

process GET_FILENAME {
    input:
    path input_file

    output: 
    stdout

    script: 
    """
    echo ${input_file}
    """

}