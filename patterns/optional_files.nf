


nextflow.enable.dsl=2

params.file_optional               = 'NO_FILE'
params.filepair_optional           = ['NO_FILE', 'NO_FILE']
params.secondaries_optional        = ['NO_FILE', 'NO_FILE']

params.file_array_optional         = ['NO_FILE']
params.filepair_array_optional     = [['NO_FILE', 'NO_FILE'], ['NO_FILE', 'NO_FILE']]
params.secondaries_array_optional  = [['NO_FILE', 'NO_FILE'], ['NO_FILE', 'NO_FILE']]

file_optional               = file( params.file_optional )
filepair_optional           = params.filepair_optional.each { value -> file(value) }
secondaries_optional        = params.secondaries_optional.each { value -> file(value) }

file_array_optional         = params.file_array_optional.each { value -> file(value) }
filepair_array_optional     = params.filepair_array_optional.each { outer -> outer.each { inner -> file(inner) } }
secondaries_array_optional  = params.secondaries_array_optional.each { outer -> outer.each { inner -> file(inner) } }

workflow {
    println file_optional
    println filepair_optional
    println secondaries_optional
    println file_array_optional
    println filepair_array_optional
    println secondaries_array_optional

    TASK1(
        file_optional,
        filepair_optional,
        secondaries_optional,
        file_array_optional,
        filepair_array_optional,
        secondaries_array_optional
    )

    TASK1.out.file_optional.view()
    TASK1.out.filepair_optional.view()
    // TASK1.out.secondaries_optional.view()
    // TASK1.out.file_array_optional.view()
    TASK1.out.filepair_array_optional.view()
    // TASK1.out.secondaries_array_optional.view()

}


// TODO try files()

process TASK1 {
    input:
    path file_optional
    path filepair_optional
    val secondaries_optional
    val file_array_optional
    val filepair_array_optional
    val secondaries_array_optional

    output:
    path file_optional, emit: file_optional
    path "{NO_FILE1,NO_FILE2}", emit: filepair_optional
    // tuple path("NO_FILE1"), path("NO_FILE2"), emit: filepair_optional
    // path secondaries_optional, emit: secondaries_optional
    // path file_array_optional, emit: file_array_optional
    tuple path("{NO_FILE3,NO_FILE4}"), path("{NO_FILE5,NO_FILE6}"), emit: filepair_array_optional
    // path secondaries_array_optional, emit: secondaries_array_optional

    script: 
    """
    echo ${file_optional} > NO_FILE
    echo ${filepair_optional[0]} > NO_FILE1
    echo ${filepair_optional[1]} > NO_FILE2
    echo ${filepair_array_optional[0][0]} > NO_FILE3
    echo ${filepair_array_optional[0][1]} > NO_FILE4
    echo ${filepair_array_optional[1][0]} > NO_FILE5
    echo ${filepair_array_optional[1][1]} > NO_FILE6
    """
}