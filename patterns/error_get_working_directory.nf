



workflow {
    STP1('hello')
}

process STP1 {
    input: 
    val mystr

    output:
    stdout
    
    script:
    """
    #!/usr/bin/env python
    import os

    work_dir = os.getcwd()
    print(work_dir)
    """
    
}