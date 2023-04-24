

nextflow.enable.dsl=2

secondaries_array  = params.secondaries_array.collect{ it.collect{ file(it) } }
secondaries        = params.secondaries.collect{ file(it) }
file_pair_array    = params.file_pair_array.collect{ it.collect{ file(it) } }
file_pair          = params.file_pair.collect{ file(it) }
file_array         = params.file_array.collect{ file(it) }
file               = file( params.file )

// println secondaries_array
// println secondaries
// println file_pair_array
// println file_pair
// println file_array
// println file

def get_primary_files(var, element_count) {
    def primary_files = []
    var.eachWithIndex {item, index -> 
        if (index % element_count == 0) {
            primary_files.add(item)
        }
    }
    return primary_files
}

workflow {
    TASK1(
        secondaries_array.flatten().toList(),
        file_pair_array.flatten().toList(),
        secondaries,
        file_pair,
        file_array,
        file,
        params.generic_array,
        params.generic
    )
}

process TASK1 {
    input:
    path secondaries_array_flat, stageAs: 'secondaries_array_flat??/*'
    tuple path(secondary1, stageAs: 'secondary1/*'), path(secondary2, stageAs: 'secondary2/*')
    path file_pair_array_flat, stageAs: 'file_pair_array_flat??/*'
    path in_file_pair, stageAs: 'in_file_pair/*'
    // tuple path(file_pair1, stageAs: 'file_pair1/*'), path(file_pair2, stageAs: 'file_pair2/*')
    path file_array, stageAs: 'file_array/*'
    path file, stageAs: 'file/*'
    val generic_array
    val generic

    output:
    stdout

    script: 
    println in_file_pair
    def secondaries_array = get_primary_files(secondaries_array_flat, 2)
    def secondaries_array_joined = secondaries_array[0].simpleName != params.NULL ? secondaries_array.join(' ') : ""
    def file_pair_array = get_primary_files(file_pair_array_flat, 2)
    def file_pair_array_joined = file_pair_array[0].simpleName != params.NULL ? file_pair_array.join(' ') : ""

    println ''
    println '--- VALUES ---'
    println secondaries_array
    println file_pair_array
    println secondary1
    println file_pair1
    println file_array
    println file
    println generic_array
    println generic
    
    println ''
    println '--- PRESENCE ---'
    println secondaries_array[0].simpleName != params.NULL ? 'secondary_array: PRESENT' : 'secondary_array: ABSENT'
    println file_pair_array[0].simpleName != params.NULL ? 'file_pair_array: PRESENT' : 'file_pair_array: ABSENT'
    println secondary1.simpleName != params.NULL ? 'secondary: PRESENT' : 'secondary: ABSENT'
    println file_pair1.simpleName != params.NULL ? 'file_pair: PRESENT' : 'file_pair: ABSENT'
    println file_array.simpleName != params.NULL ? 'file_array: PRESENT' : 'file_array: ABSENT'
    println file.simpleName != params.NULL ? 'file: PRESENT' : 'file: ABSENT'
    println generic_array != params.NULL ? 'generic_array: PRESENT' : 'generic_array: ABSENT'
    println generic != params.NULL ? 'generic: PRESENT' : 'generic: ABSENT'
    """
    """
}