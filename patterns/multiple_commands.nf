


workflow {
    TASK('hello').view()
}


process TASK {
    input:
    val myinput

    output:
    stdout

    script:
    """
    mkdir workdir
    echo ${myinput}
    """
}