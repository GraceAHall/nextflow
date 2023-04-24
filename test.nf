


process test_bed{
    output:
        path "a", emit: a
        path "b", emit: b
        path "c", emit: c

    script:
    def workdir = task.workDir

    """
    echo ${workdir}
    touch a b c
    """
}

process test_probe{
    input:
        path(in)
    script:
        """
        echo ${in}
        """
}

workflow{
    test_bed()
    test_bed.out.a.view()
}